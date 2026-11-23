// Connexion GitHub (OAuth) pour response.html (fonction Vercel)
//
// GitHub renvoie la personne sur response.html avec un « code » à usage unique. Échanger ce code
// demande le secret de l'application OAuth, qui ne doit jamais être dans la page : cette fonction
// fait l'échange côté serveur, lit le profil public, et renvoie seulement { login, name, id }.
// Le secret est la variable d'environnement Vercel GITHUB_CLIENT_SECRET.
// Adresse : https://<projet>.vercel.app/api/github?code=...

const CLIENT_ID = 'Ov23liYZ0M39fXFUlDTL';   // identifiant public de l'application OAuth GitHub
const REDIRECT_URI = 'https://antoinejarnoux.github.io/ArtificialInquiries_1/response.html';
const GITHUB = 'https://github.com';
const GITHUB_API = 'https://api.github.com';
const ALLOWED = /^(https:\/\/antoinejarnoux\.github\.io|http:\/\/(localhost|127\.0\.0\.1)(:[0-9]+)?)$/;

export default {
  async fetch(request) {
    const origin = request.headers.get('origin') || '';
    const cors = ALLOWED.test(origin) ? { 'Access-Control-Allow-Origin': origin, Vary: 'Origin' } : { Vary: 'Origin' };
    const reply = (data, status = 200) => new Response(JSON.stringify(data), {
      status, headers: { ...cors, 'Content-Type': 'application/json; charset=utf-8', 'Cache-Control': 'no-store' },
    });
    if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: cors });
    if (!ALLOWED.test(origin)) return reply({ error: 'page non autorisée par le relais' }, 403);

    const code = new URL(request.url).searchParams.get('code') || '';
    if (!/^[A-Za-z0-9_-]{8,100}$/.test(code)) return reply({ error: 'code GitHub invalide' }, 400);
    const secret = process.env.GITHUB_CLIENT_SECRET;
    if (!secret) return reply({ error: "le secret GitHub n'est pas encore réglé sur Vercel (GITHUB_CLIENT_SECRET)" }, 500);

    try {
      // 1) code → jeton (le jeton reste ici, il n'est jamais renvoyé à la page)
      const t = await fetch(GITHUB + '/login/oauth/access_token', {
        method: 'POST',
        headers: { Accept: 'application/json', 'Content-Type': 'application/json' },
        body: JSON.stringify({ client_id: CLIENT_ID, client_secret: secret, code, redirect_uri: REDIRECT_URI }),
        signal: AbortSignal.timeout(10000),
      }).then(r => r.json());
      if (!t.access_token) return reply({ error: t.error_description || 'GitHub a refusé le code' }, 400);
      // 2) jeton → profil public
      const r = await fetch(GITHUB_API + '/user', {
        headers: { Authorization: 'Bearer ' + t.access_token, Accept: 'application/vnd.github+json', 'User-Agent': 'ArtificialInquiries_1' },
        signal: AbortSignal.timeout(10000),
      });
      if (!r.ok) return reply({ error: 'GitHub ne donne pas le profil (' + r.status + ')' }, 502);
      const u = await r.json();
      return reply({ login: u.login, name: u.name || u.login, id: u.id, avatar: u.avatar_url });
    } catch (e) {
      return reply({ error: 'GitHub injoignable depuis le relais' }, 502);
    }
  },
};
