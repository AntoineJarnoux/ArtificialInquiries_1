// Connexion Google pour response.html (fonction Vercel)
//
// Le bouton Google (Google Identity Services) donne à la page un « jeton d'identité » signé par Google.
// La page l'envoie ici : le relais le fait vérifier par Google (tokeninfo), contrôle qu'il a été émis pour
// notre Client ID et qu'il n'a pas expiré, puis renvoie le nom et un jeton de session signé (lib/session.mjs)
// qui permet d'écrire dans la base par api/omk.
// Adresse : POST https://<projet>.vercel.app/api/google  { "credential": "…" }
import { sign } from '../lib/session.mjs';

const CLIENT_ID = '1046577410496-qjkqfq4448rv2iggia9tpkfve08sf40q.apps.googleusercontent.com';
const TOKENINFO = 'https://oauth2.googleapis.com/tokeninfo';
const ALLOWED = /^(https:\/\/(artificialinquiries1\.vercel\.app|antoinejarnoux\.github\.io)|http:\/\/(localhost|127\.0\.0\.1)(:[0-9]+)?)$/;
const fromPage = request => ALLOWED.test(request.headers.get('origin') || '') ||
  (!request.headers.get('origin') && request.headers.get('sec-fetch-site') === 'same-origin');

export default {
  async fetch(request) {
    const origin = request.headers.get('origin') || '';
    const cors = ALLOWED.test(origin)
      ? { 'Access-Control-Allow-Origin': origin, 'Access-Control-Allow-Methods': 'POST, OPTIONS', 'Access-Control-Allow-Headers': 'Content-Type', Vary: 'Origin' }
      : { Vary: 'Origin' };
    const reply = (data, status = 200) => new Response(JSON.stringify(data), {
      status, headers: { ...cors, 'Content-Type': 'application/json; charset=utf-8', 'Cache-Control': 'no-store' },
    });
    if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: cors });
    if (!fromPage(request)) return reply({ error: 'page non autorisée par le relais' }, 403);
    if (request.method !== 'POST') return reply({ error: 'méthode non autorisée' }, 405);

    let credential = '';
    try { credential = String((await request.json()).credential || ''); } catch (e) { /* corps illisible */ }
    if (!/^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$/.test(credential)) return reply({ error: 'jeton Google invalide' }, 400);

    let t;
    try {
      const r = await fetch(TOKENINFO + '?id_token=' + encodeURIComponent(credential), { signal: AbortSignal.timeout(10000) });
      t = await r.json();
      if (!r.ok) return reply({ error: 'Google refuse ce jeton' }, 401);
    } catch (e) { return reply({ error: 'Google injoignable depuis le relais' }, 502); }

    if (t.aud !== CLIENT_ID) return reply({ error: 'jeton émis pour une autre application' }, 401);
    if (!['accounts.google.com', 'https://accounts.google.com'].includes(t.iss)) return reply({ error: 'jeton non émis par Google' }, 401);
    if (!(Number(t.exp) * 1000 > Date.now())) return reply({ error: 'jeton expiré' }, 401);

    const name = t.name || t.email || 'Compte Google';
    try {
      return reply({ sub: t.sub, name, avatar: t.picture || '', token: sign({ p: 'google', id: t.sub, name }) });
    } catch (e) { return reply({ error: e.message }, 500); }
  },
};
