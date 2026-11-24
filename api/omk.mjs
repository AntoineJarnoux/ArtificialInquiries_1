// Relais de l'API Omeka S de la base commune pour response.html (fonction Vercel)
//
// - Lecture (GET) : transmise telle quelle, sans clé (seuls les éléments publics sont visibles).
// - Écriture (POST, PUT, PATCH, DELETE) : seulement pour une personne connectée (GitHub, Google ou CAS),
//   avec le jeton de session signé par les relais de connexion (en-tête X-Session). Le relais écrit alors
//   avec la clé API rangée dans Vercel (OMEKA_KEY_IDENTITY, OMEKA_KEY_CREDENTIAL) : la page n'en voit jamais.
// - Règles, pour protéger la base commune :
//     · on ne crée que des éléments des modèles « Ex1 … » (et un modèle « Ex1 … » s'il manque) ;
//     · chaque élément créé reçoit dcterms:creator = « fournisseur:identifiant » de la personne connectée ;
//     · on ne modifie ou supprime qu'un élément « Ex1 … » dont on est l'auteur (et ses images) ;
//     · un Participant ne peut être créé que pour soi-même.
// Adresse : https://<projet>.vercel.app/api/omk?path=items&...
import { verify, owner } from '../lib/session.mjs';

const API_URL = 'https://humanum-p8.fr/omk_artificialinquiries/api/';
const TPL = 'Ex1 ';
const ALLOWED = /^(https:\/\/(artificialinquiries1\.vercel\.app|antoinejarnoux\.github\.io)|http:\/\/(localhost|127\.0\.0\.1)(:[0-9]+)?)$/;
// La page est servie par Vercel, à la même adresse que le relais : pour une lecture (GET) sur la même adresse,
// le navigateur n'envoie pas d'en-tête Origin, mais il envoie Sec-Fetch-Site: same-origin.
const fromPage = request => ALLOWED.test(request.headers.get('origin') || '') ||
  (!request.headers.get('origin') && request.headers.get('sec-fetch-site') === 'same-origin');
const METHODS = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'];

class Refus extends Error { constructor(status, msg) { super(msg); this.status = status; } }

const keyQuery = () => {
  const i = process.env.OMEKA_KEY_IDENTITY, c = process.env.OMEKA_KEY_CREDENTIAL;
  return i && c ? 'key_identity=' + encodeURIComponent(i) + '&key_credential=' + encodeURIComponent(c) : '';
};
const withKey = (pathAndQuery) => API_URL + pathAndQuery + (pathAndQuery.includes('?') ? '&' : '?') + keyQuery();
async function omekaJson(pathAndQuery) {
  const r = await fetch(withKey(pathAndQuery), { headers: { Accept: 'application/json' } });
  if (!r.ok) throw new Refus(r.status === 404 ? 404 : 502, 'élément introuvable dans la base (' + r.status + ')');
  return r.json();
}

// Modèles « Ex1 … » et propriétés utiles (gardés 5 minutes)
let cache = null;
async function meta() {
  if (cache && Date.now() - cache.at < 300e3) return cache;
  const [rts, creator, fournisseur, identifiant] = await Promise.all([
    omekaJson('resource_templates?per_page=500'),
    omekaJson('properties?term=dcterms:creator'),
    omekaJson('properties?term=artinq:fournisseur'),
    omekaJson('properties?term=artinq:identifiant'),
  ]);
  const ex1 = rts.filter(t => String(t['o:label']).startsWith(TPL));
  cache = {
    at: Date.now(),
    ex1: new Set(ex1.map(t => t['o:id'])),
    labels: new Set(rts.map(t => t['o:label'])),
    participant: (ex1.find(t => t['o:label'] === TPL + 'Participant') || {})['o:id'],
    P: { creator: (creator[0] || {})['o:id'], fournisseur: (fournisseur[0] || {})['o:id'], identifiant: (identifiant[0] || {})['o:id'] },
  };
  if (!cache.P.creator) throw new Refus(500, 'propriété dcterms:creator absente de la base');
  return cache;
}

const tplId = d => d && d['o:resource_template'] && d['o:resource_template']['o:id'];
const texts = (d, term) => (d[term] || []).map(v => v && v['@value']).filter(v => v !== undefined).map(String);

// L'élément existe, est un « Ex1 … » et a été créé par cette personne
async function mustOwn(id, tag, M) {
  if (!/^[0-9]+$/.test(String(id))) throw new Refus(400, 'identifiant invalide');
  const it = await omekaJson('items/' + id);
  if (!M.ex1.has(tplId(it))) throw new Refus(403, "cet élément n'appartient pas à l'exercice 1");
  if (!texts(it, 'dcterms:creator').includes(tag)) throw new Refus(403, "tu ne peux modifier ou supprimer que tes propres réponses");
  return it;
}

// Lit le corps : JSON, ou multipart (champ « data » en JSON + fichiers)
async function readBody(request) {
  const type = request.headers.get('content-type') || '';
  const buf = await request.arrayBuffer();
  if (type.startsWith('multipart/form-data')) {
    const fd = await new Response(buf, { headers: { 'content-type': type } }).formData();
    let data;
    try { data = JSON.parse(fd.get('data')); } catch (e) { throw new Refus(400, 'données illisibles'); }
    return { multipart: true, fd, data, buf, type };
  }
  let data = null;
  if (buf.byteLength) { try { data = JSON.parse(new TextDecoder().decode(buf)); } catch (e) { throw new Refus(400, 'données illisibles'); } }
  return { multipart: false, data, buf, type };
}
// Réécrit le corps après modification de « data »
function encode(b) {
  if (!b.multipart) return { body: JSON.stringify(b.data), type: 'application/json' };
  const out = new FormData();
  for (const [k, v] of b.fd.entries()) out.append(k, k === 'data' ? JSON.stringify(b.data) : v);
  return { body: out, type: null };   // fetch ajoute lui-même le type multipart et sa frontière
}

// Vérifie une écriture et renvoie le corps à transmettre (null = corps d'origine)
async function checkWrite(method, path, request, user) {
  const M = await meta();
  const tag = owner(user);
  const [res, id] = path.split('/');
  const setCreator = d => { d['dcterms:creator'] = [{ type: 'literal', property_id: M.P.creator, '@value': tag }]; };

  if (res === 'resource_templates' && method === 'POST' && !id) {
    const b = await readBody(request);
    const label = String((b.data || {})['o:label'] || '');
    if (!label.startsWith(TPL)) throw new Refus(403, 'seuls les modèles « Ex1 … » peuvent être créés');
    if (M.labels.has(label)) throw new Refus(409, 'ce modèle existe déjà');
    cache = null;
    return { body: b.buf, type: b.type };
  }

  if (res === 'items') {
    if (method === 'POST' && !id) {
      const b = await readBody(request);
      const d = b.data || {};
      if (!M.ex1.has(tplId(d))) throw new Refus(403, 'seuls les éléments des modèles « Ex1 … » peuvent être créés');
      if (tplId(d) === M.participant &&
          (!texts(d, 'artinq:fournisseur').every(v => v === user.p) || !texts(d, 'artinq:identifiant').every(v => v === String(user.id)) ||
           !texts(d, 'artinq:fournisseur').length || !texts(d, 'artinq:identifiant').length)) {
        throw new Refus(403, 'un participant ne peut être créé que pour la personne connectée');
      }
      setCreator(d);
      return encode(b);
    }
    if ((method === 'PUT' || method === 'PATCH') && id) {
      await mustOwn(id, tag, M);
      const b = await readBody(request);
      const d = b.data || {};
      if (method === 'PUT' && !M.ex1.has(tplId(d))) throw new Refus(403, 'le modèle « Ex1 … » doit être gardé');
      if (method === 'PATCH' && d['o:resource_template'] && !M.ex1.has(tplId(d))) throw new Refus(403, 'le modèle « Ex1 … » doit être gardé');
      setCreator(d);
      return encode(b);
    }
    if (method === 'DELETE' && id) { await mustOwn(id, tag, M); return { body: null, type: null }; }
  }

  if (res === 'media') {
    if (method === 'POST' && !id) {
      const b = await readBody(request);
      const itemId = b.data && b.data['o:item'] && b.data['o:item']['o:id'];
      await mustOwn(itemId, tag, M);
      return { body: b.buf, type: b.type };
    }
    if (method === 'DELETE' && id) {
      if (!/^[0-9]+$/.test(id)) throw new Refus(400, 'identifiant invalide');
      const m = await omekaJson('media/' + id);
      await mustOwn(m['o:item'] && m['o:item']['o:id'], tag, M);
      return { body: null, type: null };
    }
  }
  throw new Refus(403, 'opération non autorisée par le relais');
}

export default {
  async fetch(request) {
    const origin = request.headers.get('origin') || '';
    const cors = ALLOWED.test(origin)
      ? {
          'Access-Control-Allow-Origin': origin,
          'Access-Control-Allow-Methods': METHODS.join(', ') + ', OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type, X-Session',
          'Access-Control-Max-Age': '600',
          Vary: 'Origin',
        }
      : { Vary: 'Origin' };
    const fail = (status, msg) => new Response(JSON.stringify({ errors: { relais: msg } }), {
      status, headers: { ...cors, 'Content-Type': 'application/json; charset=utf-8' },
    });

    if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: cors });
    if (!fromPage(request)) return fail(403, 'page non autorisée par le relais');
    if (!METHODS.includes(request.method)) return fail(405, 'méthode non autorisée');

    // Chemin de l'API (items, items/12, media, resource_templates…) et paramètres d'origine, sans « path »
    const url = new URL(request.url);
    const path = url.searchParams.get('path') || '';
    if (!/^[a-z_]+(\/[0-9]+)?$/.test(path)) return fail(400, 'chemin invalide');
    url.searchParams.delete('path');
    url.searchParams.delete('key_identity');
    url.searchParams.delete('key_credential');

    let target = API_URL + path + url.search;
    const init = { method: request.method, headers: { Accept: 'application/json' } };
    if (request.method !== 'GET') {
      const user = verify(request.headers.get('x-session'));
      if (!user) return fail(401, 'connecte-toi pour enregistrer (session absente ou expirée)');
      if (!keyQuery()) return fail(500, "la clé Omeka n'est pas encore réglée sur Vercel (OMEKA_KEY_IDENTITY, OMEKA_KEY_CREDENTIAL)");
      try {
        const out = await checkWrite(request.method, path, request, user);
        if (out.body !== null && out.body !== undefined) init.body = out.body;
        if (out.type) init.headers['Content-Type'] = out.type;
      } catch (e) {
        if (e instanceof Refus) return fail(e.status, e.message);
        return fail(502, 'base commune injoignable depuis le relais');
      }
      target += (url.search ? '&' : '?') + keyQuery();
    }

    let r;
    try { r = await fetch(target, init); }
    catch (e) { return fail(502, 'la base commune (humanum-p8.fr) ne répond pas au relais : réessaie dans quelques minutes.'); }
    const body = r.status === 204 ? null : await r.arrayBuffer();
    return new Response(body, {
      status: r.status,
      headers: { ...cors, 'Content-Type': r.headers.get('content-type') || 'application/json' },
    });
  },
};
