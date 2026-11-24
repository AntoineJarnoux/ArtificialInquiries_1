# ArtificialInquiries_1 — « Draw It Like You See It »

Transformation en outil numérique de l'**exercice 1** du vademecum *Artificial Inquiries: A Vademecum for Workers in the Age of AI* (Alcaras, Ricci, Prinetti, de Vries, médialab Sciences Po, 2025 — [https://hal.science/hal-05327878](https://hal.science/hal-05327878)).

**Page en ligne : [https://artificialinquiries1.vercel.app/](https://artificialinquiries1.vercel.app/)** (l'ancienne adresse [https://antoinejarnoux.github.io/ArtificialInquiries_1/response.html](https://antoinejarnoux.github.io/ArtificialInquiries_1/response.html) y renvoie).

---

## 1. L'exercice

**Bloc 01 — Qualifying, exercice 1 (p. 6-7).** C'est le premier exercice du livre : avant de documenter son usage des LLM, on fixe sa représentation de départ.

Sur papier, la page contient :

- **deux carrés à dessiner**, de tête, sans faire de recherche :
  1. à quoi ressemble un LLM (comment on imagine son fonctionnement) ;
  2. à quoi ressemble son environnement de travail ;
- **une question écrite** : « En quelques mots, que fais-tu ? ».

L'intérêt est de **comparer les deux dessins** : est-ce que le LLM apparaît dans le dessin du travail ? Qu'est-ce qui revient dans les deux ?

## 2. Pourquoi un outil numérique

Sur papier, on n'a qu'une page et on ne la refait pas. En numérique :

- on peut **refaire l'exercice à plusieurs moments** (avant les autres exercices, après un bloc, à la fin de l'enquête) et voir comment sa vision évolue ;
- les réponses sont **enregistrées dans la base Omeka S commune du cours**, avec le vocabulaire commun `artinq`, à côté de celles des autres exercices ;
- on peut **regarder les réponses des autres** et comparer.

## 3. Utiliser la page

### Se connecter

| Méthode | Ce qu'il faut | Ce qu'on peut faire |
|---|---|---|
| **Clé API Omeka S** | email + `key_identity` + `key_credential`, créés sur la base commune (ton nom → Edit → API keys) | faire l'exercice, modifier, supprimer |
| **GitHub** | bouton « Se connecter avec GitHub » (ou un jeton personnel si l'application OAuth n'est pas réglée) | lecture seule, ou écriture si la clé API est aussi remplie |
| **Google** | bouton Google | idem |
| **Université Paris 8 (CAS)** | identifiant de la fac | idem |
| **Sans compte** | rien | lecture seule : voir les réponses |

L'écriture dans la base demande toujours une clé API Omeka : GitHub, Google et le CAS servent à dire **qui** on est (un participant par compte : `fournisseur` + `identifiant`). Si la base refuse la clé, la page l'explique et passe en lecture seule.

### Où va la clé API

- **Jamais dans l'adresse des requêtes** : la page l'envoie au relais dans deux en-têtes (`X-Omeka-Key-Identity`, `X-Omeka-Key-Credential`). Elle n'apparaît donc ni dans l'historique, ni dans les journaux de Vercel. C'est le relais qui l'ajoute à l'adresse de l'API, côté serveur, car Omeka S ne la lit que là.
- **Gardée seulement dans l'onglet** par défaut (`sessionStorage`) : elle s'efface quand on ferme l'onglet.
- **« Garder ma clé sur cet ordinateur »** la garde dans le navigateur (`localStorage`) jusqu'à « Se déconnecter ». À ne pas cocher sur un ordinateur partagé.
- **« Se déconnecter »** efface la clé partout. Après une connexion CAS, la page ferme aussi la session du CAS de Paris 8 (`/cas/logout`), puis revient sur la page.
- **Si le relais ne répond plus**, la page le dit : « Le relais Vercel (…) ne répond pas : la base commune est inaccessible depuis cette page pour le moment ». Si c'est la base commune qui ne répond pas, le relais le dit aussi.

### Fonctionnalités

| Fonction | Détail |
|---|---|
| Dessin | 2 carrés, 5 couleurs, gomme ; souris, doigt ou stylet |
| Annuler / effacer | par carré : dernier trait, ou tout |
| Question écrite | « En quelques mots, que fais-tu ? » |
| Moment | avant les autres exercices, après le bloc 02, 03 ou 04, à la fin de l'enquête |
| Mes réponses | liste de ses passations, avec les 2 dessins et la phrase |
| Réponses des autres | case « Voir aussi les réponses des autres » (toujours affiché en lecture seule) |
| CRUD | **C**réer (Faire l'exercice), **R**elire (liste), **M**odifier (redessiner, changer la phrase), **S**upprimer (avec confirmation) |

## 4. Solutions techniques

### Architecture

```mermaid
flowchart LR
    U(["Participant"]) --> P["response.html<br/>artificialinquiries1.vercel.app"]
    GP["ancienne adresse<br/>GitHub Pages"] -.->|"renvoie"| P
    subgraph V["Vercel (même adresse)"]
        P
        R1["Relais api/omk"]
        R2["Relais api/cas"]
        R3["Relais api/github"]
    end
    P -->|"API Omeka S"| R1
    R1 --> O[("Base Omeka S commune<br/>humanum-p8.fr")]
    P -->|"ticket CAS"| R2
    R2 --> C["CAS Paris 8"]
    P -->|"code GitHub"| R3
    R3 --> G["GitHub OAuth"]
    P -->|"Google Identity Services"| GG["Google"]
```

- **Page** : HTML / CSS / JavaScript sans framework, en un seul fichier. Vercel la sert à la racine du site (`vercel.json` : `/` → `response.html`), donc on arrive directement sur l'écran de connexion. `.vercelignore` fait que Vercel ne publie que la page et les relais. L'ancienne page GitHub Pages renvoie vers Vercel.
- **Pourquoi des relais** : la base commune n'envoie pas d'en-tête CORS, donc un navigateur ne peut pas l'appeler depuis une autre adresse. Les fonctions Vercel du dossier `api/`, à la même adresse que la page, font l'appel côté serveur. Elles n'acceptent que la page de ce dépôt (et `localhost` pour les tests), et ne relaient que la base commune.
  - `api/omk.mjs` : relaie l'API Omeka S (GET, POST, PUT, DELETE, envoi d'images).
  - `api/cas.mjs` : vérifie le ticket du CAS de Paris 8 (`serviceValidate`), que le navigateur ne peut pas vérifier seul.
  - `api/github.mjs` : échange le code GitHub contre un jeton avec le secret de l'application OAuth (variable Vercel `GITHUB_CLIENT_SECRET`), puis renvoie seulement le nom public. Le jeton et le secret ne vont jamais dans la page. L'adresse de retour déclarée chez GitHub est restée l'ancienne page GitHub Pages, qui renvoie aussitôt vers Vercel avec le code.
- **Dessin** : Canvas 2D + Pointer Events (souris, doigt, stylet). Chaque trait est gardé comme `{outil, couleur, epaisseur, points[]}`, ce qui permet d'annuler et de redessiner.

### Les données dans Omeka S

- Le modèle est décrit dans **[diagram_class.md](diagram_class.md)**.
- Vocabulaire commun `artinq` ([artificial_inquiries.ttl](artificial_inquiries.ttl) en reprend les termes utilisés) et 7 modèles de ressource **« Ex1 … »** ([resource-template/](resource-template/)).
- Une passation = 1 item `Passation`, relié à son `Participant`, à l'item « Exercice 1 » et à ses 3 réponses. Un dessin = 1 item `ReponseDessin` avec son image PNG (média) et un item `Trait` par trait (les points sont dans `artinq:points`, en JSON).
- À la première connexion avec une clé, la page crée elle-même les modèles « Ex1 … » et les 3 questions s'ils manquent.

## 5. Structure du dépôt

```
ArtificialInquiries_1/
├── response.html              la page (interface + CRUD)
├── vercel.json                la racine du site Vercel affiche response.html
├── .vercelignore              Vercel ne publie que la page et api/
├── api/
│   ├── omk.mjs                relais de l'API Omeka S (Vercel)
│   ├── cas.mjs                relais de validation CAS (Vercel)
│   └── github.mjs             connexion GitHub OAuth (Vercel)
├── resource-template/         les 7 modèles « Ex1 … » (export Omeka S)
├── artificial_inquiries.ttl   termes du vocabulaire artinq utilisés
├── diagram_class.md           diagramme de classes Mermaid
├── cas/validate.php           ancien relais CAS pour un Omeka local (XAMPP)
├── omk.sql                    export de la base locale de développement
└── README.md
```

## 6. Mise en place (pour refaire le déploiement)

1. **Vercel** : importer le dépôt (préréglage « Other »). La page est servie à la racine `https://<projet>.vercel.app/` et les fichiers de `api/` deviennent les relais `https://<projet>.vercel.app/api/...`.
2. **GitHub Pages** sur la branche `main` (racine) : garde l'ancienne adresse, qui renvoie vers Vercel (script en tête de `response.html`).
3. **GitHub OAuth** : créer une application OAuth (GitHub → Settings → Developer settings → OAuth Apps) avec comme *callback URL* l'adresse GitHub Pages de `response.html` (`GITHUB_CALLBACK` dans la page, `REDIRECT_URI` dans `api/github.mjs`), mettre son Client ID dans `response.html` (`DEFAULTS.github`) et `api/github.mjs`, et son secret dans la variable Vercel `GITHUB_CLIENT_SECRET`.
4. **Google** : un Client ID OAuth « Application Web » avec l'origine `https://<projet>.vercel.app` dans « Origines JavaScript autorisées », dans `DEFAULTS.google`.

## 7. Tests

La page a été testée de bout en bout sur un Omeka S 4.2.1 de test, avec les relais et un faux CAS (37 vérifications, plus 6 pour l'adresse Vercel : écran de connexion à la racine, renvoi depuis github.io, retour GitHub, CAS et visiteur) : connexion avec et sans clé, clé refusée, mode sans compte, GitHub, Google, CAS, puis Create, Read, Update et Delete (avec les images et les traits). Les tests vérifient aussi que la clé n'est dans aucune adresse de requête, qu'elle est effacée à la déconnexion, et les messages quand le relais ou la base ne répondent pas.

**Avec le vrai CAS de Paris 8** (`cas.univ-paris8.fr`), le 24/11/2026 :

| Étape | Résultat |
|---|---|
| « Se connecter avec l'université » | la page de connexion du CAS s'ouvre et accepte l'adresse de `response.html` comme service |
| Vérification du ticket par le relais `api/cas` | le relais interroge bien le vrai CAS : un faux ticket est refusé (`INVALID_TICKET`, « le ticket … est inconnu ») |
| Déconnexion | `/cas/logout?service=…` ferme la session du CAS et renvoie sur `response.html` |

## 8. Références

- Alcaras G., Ricci D., Prinetti T., de Vries Z. (2025). *Artificial Inquiries*. Éditions Annexes / médialab Sciences Po. [https://hal.science/hal-05327878](https://hal.science/hal-05327878)
- API Omeka S : [https://omeka.org/s/docs/developer/api/](https://omeka.org/s/docs/developer/api/)
- Mermaid, diagramme de classes : [https://mermaid.js.org/syntax/classDiagram.html](https://mermaid.js.org/syntax/classDiagram.html)
