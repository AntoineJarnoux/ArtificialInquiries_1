// Relais de l'API Omeka S de la base commune pour response.html (fonction Vercel)
//
// La base commune (humanum-p8.fr) n'envoie pas d'en-tête CORS : un navigateur ne peut donc pas
// l'appeler depuis GitHub Pages. Cette fonction transmet la requête à l'API côté serveur,
// puis renvoie la réponse à la page avec l'en-tête CORS.
// Adresse : https://<projet>.vercel.app/api/omk?path=items&...
// Elle ne relaie que l'API de la base commune, et seulement pour les pages autorisées ci-dessous.

const API_URL = 'https://humanum-p8.fr/omk_artificialinquiries/api/';
const ALLOWED = /^(https:\/\/antoinejarnoux\.github\.io|http:\/\/(localhost|127\.0\.0\.1)(:[0-9]+)?)$/;
const METHODS = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'];

export default {
  async fetch(request) {
    const origin = request.headers.get('origin') || '';
    const cors = ALLOWED.test(origin)
      ? {
          'Access-Control-Allow-Origin': origin,
          'Access-Control-Allow-Methods': METHODS.join(', ') + ', OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Max-Age': '600',
          Vary: 'Origin',
        }
      : { Vary: 'Origin' };
    const fail = (status, msg) => new Response(JSON.stringify({ errors: { relais: msg } }), {
      status, headers: { ...cors, 'Content-Type': 'application/json; charset=utf-8' },
    });

    if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: cors });
    if (!ALLOWED.test(origin)) return fail(403, 'page non autorisée par le relais');
    if (!METHODS.includes(request.method)) return fail(405, 'méthode non autorisée');

    // Chemin de l'API (items, items/12, media, resource_templates…) et paramètres d'origine, sans « path »
    const url = new URL(request.url);
    const path = url.searchParams.get('path') || '';
    if (!/^[a-z_]+(\/[0-9]+)?$/.test(path)) return fail(400, 'chemin invalide');
    url.searchParams.delete('path');

    const init = { method: request.method, headers: { Accept: 'application/json' } };
    if (request.method !== 'GET' && request.method !== 'DELETE') {
      // JSON ou envoi d'image (multipart) : le corps est retransmis tel quel, avec son Content-Type
      const type = request.headers.get('content-type');
      if (type) init.headers['Content-Type'] = type;
      init.body = await request.arrayBuffer();
    }

    let r;
    try { r = await fetch(API_URL + path + url.search, init); }
    catch (e) { return fail(502, 'API Omeka S injoignable depuis le relais'); }
    const body = r.status === 204 ? null : await r.arrayBuffer();
    return new Response(body, {
      status: r.status,
      headers: { ...cors, 'Content-Type': r.headers.get('content-type') || 'application/json' },
    });
  },
};
