# Cross Site Scripting (XSS)

## URL
`/?page=feedback`

## Description
Les attaques Cross-Site Scripting (XSS) surviennent lorsque :

- Des données provenant d'une source non fiable, souvent une requête web, pénètrent dans une application web.

- Ces données sont incluses dans du contenu dynamique envoyé à l'utilisateur sans être validées pour détecter des contenus malveillants.

- Le contenu malveillant envoyé au navigateur prend souvent la forme de JavaScript, mais peut aussi inclure du HTML, Flash ou tout autre type de code exécutable par le navigateur.

- Les attaques XSS peuvent permettre de voler des données privées (comme des cookies), rediriger la victime vers du contenu contrôlé par l'attaquant ou exécuter d'autres actions malveillantes sous l'apparence du site vulnérable.

[Lien OWASP XSS faille](https://owasp.org/www-community/attacks/xss/)

## Se protéger
Philosophie générale:
Pour qu'une attaque XSS soit réussie, l'attaquant doit pouvoir insérer et exécuter du contenu malveillant dans une page web. Il est donc essentiel de protéger toutes les variables dans une application web. Cela implique de s'assurer que toutes les variables sont validées, puis échappées ou assainies, ce que l'on appelle une résistance parfaite aux injections. Toute variable qui ne suit pas ce processus représente une faiblesse potentielle. Les frameworks facilitent cette validation et cette échappement ou assainissement des variables.

Cependant, aucun framework n'est infaillible, et des failles de sécurité peuvent encore exister dans des frameworks populaires comme React et Angular. L'encodage de sortie et la sanitation HTML aident à combler ces lacunes.

- Toujours valider/nettoyer les entrées utilisateurs. Avant de traiter l'input utilisateur, échaper tous les caractères spéciaux, ne rien interpréter.
- Utiliser la sécurité fournie par les frameworks


[Lien OWASP XSS Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html)

## Reproduire la faille
On a écrit **script** dans le champ Message de ce formulaire. Mettre un nom bidon.

