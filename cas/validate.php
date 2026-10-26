<?php
/**
 * Relais de validation CAS pour response.html
 *
 * Le CAS de Paris 8 n'autorise pas un navigateur à vérifier un ticket depuis une autre adresse (pas d'en-tête CORS).
 * Ce petit script fait la vérification côté serveur, puis renvoie le résultat en JSON à response.html.
 *
 * Installation (XAMPP) : copier ce fichier dans C:\xampp\htdocs\ai1-cas\validate.php
 * Adresse : http://localhost/ai1-cas/validate.php?service=...&ticket=ST-...
 */

$CAS_URL          = 'https://cas.univ-paris8.fr/cas';                          // serveur CAS
$SERVICE_PREFIX   = 'https://antoinejarnoux.github.io/ArtificialInquiries_1/'; // seules les pages de ce dépôt sont acceptées
$ALLOWED_ORIGINS  = ['https://antoinejarnoux.github.io', 'http://localhost', 'http://127.0.0.1'];

// CORS : n'autorise que les pages de l'exercice
$origin = $_SERVER['HTTP_ORIGIN'] ?? '';
if (in_array($origin, $ALLOWED_ORIGINS, true)) {
    header('Access-Control-Allow-Origin: ' . $origin);
    header('Access-Control-Allow-Private-Network: true');
    header('Vary: Origin');
}
if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'OPTIONS') {
    http_response_code(204);
    exit;
}
header('Content-Type: application/json; charset=utf-8');

function reply($data, $code = 200) {
    http_response_code($code);
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
}

$service = $_GET['service'] ?? '';
$ticket  = $_GET['ticket'] ?? '';
if (strpos($service, $SERVICE_PREFIX) !== 0) reply(['error' => 'service non autorisé'], 400);
if (!preg_match('/^ST-[A-Za-z0-9._\-]+$/', $ticket)) reply(['error' => 'ticket invalide'], 400);

// Vérification du ticket auprès du serveur CAS (protocole CAS 2, réponse XML)
$url = $CAS_URL . '/serviceValidate?service=' . rawurlencode($service) . '&ticket=' . rawurlencode($ticket);
$ctx = stream_context_create(['http' => ['timeout' => 10, 'ignore_errors' => true]]);
$xml = @file_get_contents($url, false, $ctx);
if ($xml === false) reply(['error' => 'serveur CAS injoignable depuis XAMPP'], 502);

$doc = new DOMDocument();
if (!@$doc->loadXML($xml)) reply(['error' => 'réponse CAS illisible'], 502);
$xp = new DOMXPath($doc);
$xp->registerNamespace('cas', 'http://www.yale.edu/tp/cas');

$user = trim($xp->evaluate('string(//cas:authenticationSuccess/cas:user)'));
if ($user !== '') {
    reply(['serviceResponse' => ['authenticationSuccess' => ['user' => $user]]]);
}
$why = trim($xp->evaluate('string(//cas:authenticationFailure)'));
$code = $xp->evaluate('string(//cas:authenticationFailure/@code)');
reply(['serviceResponse' => ['authenticationFailure' => ['code' => $code, 'description' => $why !== '' ? $why : 'ticket refusé']]]);
