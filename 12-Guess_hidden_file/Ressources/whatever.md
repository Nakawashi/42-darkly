# hidden

## URL

Première url trouvée avec le nom du dossier : `/robots.txt`
Url : `/.hidden/`

## Description

Le fichier robots.txt est utilisé pour indiquer aux moteurs de recherche quels répertoires ou pages du site web ne doivent pas être indexés. Si ce fichier contient des répertoires ou des chemins d'accès à des dossiers cachés (par exemple, un dossier appelé "hidden"), cela peut conduire à une fuite d'information. En effet, bien que le fichier robots.txt n'empêche pas un attaquant d'accéder à ces répertoires, il leur permet de découvrir des chemins qui pourraient contenir des données sensibles ou des fichiers intéressants.

Si le fichier robots.txt contient une directive qui empêche l'accès à ces répertoires sensibles, cela peut attirer l'attention des attaquants. Ils pourraient penser que ces répertoires cachent des informations intéressantes et tenter d'y accéder. En d'autres termes, l'usage incorrect du fichier robots.txt peut paradoxalement inciter un attaquant à explorer davantage ces chemins interdits.

## Se protéger

Le problème principal réside dans le fait que les fichiers sont accessibles via le serveur web. Si les fichiers contenant des informations sensibles ou des flags sont accessibles publiquement, cela constitue une vulnérabilité. Idéalement, ces fichiers devraient être protégés par des restrictions d'accès, par exemple en autorisant uniquement l'accès aux administrateurs du site web, via des contrôles d'accès sur le serveur (comme un mot de passe ou une restriction d'IP).

Si ces fichiers sont accessibles à tout le monde via le serveur web, un attaquant pourrait facilement les récupérer, ce qui compromettrait la sécurité du site. Il est donc crucial de mettre en place des mesures de sécurité pour restreindre l'accès à ces fichiers sensibles.

Quelques idées pour éviter la faille :

- **Réviser le fichier robots.txt** : Ne pas inclure des répertoires ou des fichiers sensibles dans le fichier robots.txt, car cela peut attirer l'attention des attaquants. Passer plutôt par des contrôles d'accès sur le serveur.
- **Restreindre l'accès au serveur web** : Limiter l'accès aux répertoires sensibles uniquement aux utilisateurs ou administrateurs autorisés. Cela peut être réalisé par des configurations serveur (comme .htaccess ou des règles de firewall).
- **Utiliser une bonne gestion des permissions** : Veiller à ce que les fichiers contenant des informations sensibles soient protégés par des mécanismes d'authentification et que seuls les utilisateurs autorisés puissent y accéder.

En résumé : restreindre l'accès aux fichiers sensibles et ne pas exposer des informations de manière aussi évidente.

## ## Reproduire la faille

Via la page /robots.txt qui sert à indiquer aux robots des moteurs de recherches les urls qu'il peut scanner sur notre site. C'est pour alléger le nomber de requêtes reçues et protéger le serveur d'une surcharge.
Il fallait trouver le flag parmi tout un tas de dossiers et sous-dossiers et fichiers. Un script bash nous a permi de trouver :
FLAG trouvé dans http://192.168.1.70/.hidden/whtccjokayshttvxycsvykxcfm/igeemtxnvexvxezqwntmzjltkt/lmpanswobhwcozdqixbowvbrhw/README

[Source OWASP](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/01-Information_Gathering/03-Review_Webserver_Metafiles_for_Information_Leakage)


