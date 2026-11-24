// Jeton de session signé, partagé par les relais (api/github, api/cas, api/google, api/omk)
//
// Après une connexion GitHub, Google ou CAS vérifiée côté serveur, le relais remet à la page un jeton :
//   base64url({ p: fournisseur, id: identifiant, name: nom, exp: expiration }) + "." + signature HMAC-SHA256
// La page le renvoie au relais api/omk pour écrire. Sans le secret (variable Vercel), impossible de le fabriquer.
import { createHmac, timingSafeEqual } from 'node:crypto';

const HOURS = 12;
const secret = () => process.env.SESSION_SECRET || process.env.GITHUB_CLIENT_SECRET || '';
const b64 = s => Buffer.from(s).toString('base64url');
const mac = (data, key) => createHmac('sha256', key).update(data).digest('base64url');

export function sign(user) {
  const key = secret();
  if (!key) throw new Error('secret de session absent sur Vercel (SESSION_SECRET ou GITHUB_CLIENT_SECRET)');
  const payload = b64(JSON.stringify({ p: user.p, id: String(user.id), name: user.name || String(user.id), exp: Date.now() + HOURS * 3600e3 }));
  return payload + '.' + mac(payload, key);
}

// Renvoie { p, id, name, exp } si le jeton est valide et pas expiré, sinon null
export function verify(token) {
  const key = secret();
  if (!key || typeof token !== 'string') return null;
  const [payload, sig] = token.split('.');
  if (!payload || !sig) return null;
  const a = Buffer.from(sig), b = Buffer.from(mac(payload, key));
  if (a.length !== b.length || !timingSafeEqual(a, b)) return null;
  try {
    const u = JSON.parse(Buffer.from(payload, 'base64url').toString());
    return u && u.p && u.id && u.exp > Date.now() ? u : null;
  } catch (e) { return null; }
}

// Étiquette d'auteur posée sur chaque élément écrit par le relais (dcterms:creator) : « github:login », « cas:jdupont »…
export const owner = u => u.p + ':' + u.id;
