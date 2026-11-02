// Relais de validation CAS pour response.html (fonction Vercel)
//
// Le CAS de Paris 8 n'autorise pas un navigateur à vérifier un ticket depuis une autre adresse
// (pas d'en-tête CORS). Cette fonction fait la vérification côté serveur, puis renvoie le résultat
// en JSON à response.html. Même rôle que cas/validate.php, mais hébergé en ligne.
// Adresse : https://<projet>.vercel.app/api/cas?service=...&ticket=ST-...

const CAS_URL = 'https://cas.univ-paris8.fr/cas';
const SERVICE_PREFIX = 'https://antoinejarnoux.github.io/ArtificialInquiries_1/'; // seules les pages de ce dépôt
const ALLOWED = /^(https:\/\/antoinejarnoux\.github\.io|http:\/\/(localhost|127\.0\.0\.1)(:[0-9]+)?)$/;

const xmlText = (xml, re) => {
  const m = xml.match(re);
  return m ? m[1].replace(/<[^>]+>/g, '')
    .replace(/&#(\d+);/g, (_, n) => String.fromCharCode(n)).replace(/&#x([0-9a-f]+);/gi, (_, n) => String.fromCharCode(parseInt(n, 16)))
    .replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&apos;/g, "'").replace(/&amp;/g, '&').trim() : '';
};

export default {
  async fetch(request) {
    const origin = request.headers.get('origin') || '';
    const cors = ALLOWED.test(origin) ? { 'Access-Control-Allow-Origin': origin, Vary: 'Origin' } : { Vary: 'Origin' };
    const reply = (data, status = 200) => new Response(JSON.stringify(data), {
      status, headers: { ...cors, 'Content-Type': 'application/json; charset=utf-8' },
    });
    if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: cors });

    const q = new URL(request.url).searchParams;
    const service = q.get('service') || '';
    const ticket = q.get('ticket') || '';
    if (!service.startsWith(SERVICE_PREFIX)) return reply({ error: 'service non autorisé' }, 400);
    if (!/^ST-[A-Za-z0-9._-]+$/.test(ticket)) return reply({ error: 'ticket invalide' }, 400);

    // Vérification du ticket auprès du serveur CAS (protocole CAS 2, réponse XML)
    let xml;
    try {
      const r = await fetch(CAS_URL + '/serviceValidate?service=' + encodeURIComponent(service) + '&ticket=' + encodeURIComponent(ticket),
        { signal: AbortSignal.timeout(10000) });
      xml = await r.text();
    } catch (e) { return reply({ error: 'serveur CAS injoignable depuis le relais' }, 502); }

    const user = xmlText(xml, /<cas:user>([\s\S]*?)<\/cas:user>/);
    if (user) return reply({ serviceResponse: { authenticationSuccess: { user } } });
    if (!/authenticationFailure/.test(xml)) return reply({ error: 'réponse CAS illisible' }, 502);
    const code = (xml.match(/<cas:authenticationFailure[^>]*code=["']([^"']*)["']/) || [])[1] || '';
    const description = xmlText(xml, /<cas:authenticationFailure[^>]*>([\s\S]*?)<\/cas:authenticationFailure>/) || 'ticket refusé';
    return reply({ serviceResponse: { authenticationFailure: { code, description } } });
  },
};
