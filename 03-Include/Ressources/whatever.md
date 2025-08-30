# Path Traversal


## URL
`http://localhost:4242/?page=media&src=nsa`

## Description

Une attaque par traversée de répertoire (aussi appelée directory traversal) vise à accéder à des fichiers et répertoires situés en dehors du dossier racine du serveur web
En manipulant des variables qui font référence à des fichiers à l'aide de séquences comme "dot-dot-slash (../)" et ses variations, ou en utilisant des chemins de fichiers absolus, il peut être possible d’accéder à des fichiers et répertoires arbitraires stockés sur le système de fichiers, y compris le code source de l'application, ses fichiers de configuration, ou des fichiers système critiques. Il est à noter que l'accès aux fichiers est limité par les contrôles d'accès opérationnels du système (comme dans le cas de fichiers verrouillés ou en cours d’utilisation sur le système d'exploitation Microsoft Windows).

Cette attaque est également connue sous les noms de "dot-dot-slash", "directory traversal", "directory climbing" et "backtracking".

Exemple d'attaque :
Supposons qu'un serveur web ait une URL qui permet de lire un fichier spécifique, comme `http://example.com/showfile?filename=readme.txt`. Un attaquant pourrait manipuler la requête pour tenter d'accéder à un fichier en dehors du dossier prévu :

```
http://example.com/showfile?filename=../../../../etc/passwd
```

[Source OWASP](https://owasp.org/www-community/attacks/Path_Traversal)

## Se protéger

Identifier si notre serveur web est dans une situation vulnérable :
- Assurez-vous de comprendre comment le système d'exploitation sous-jacent traitera les noms de fichiers qui lui sont transmis.
- Ne stockez pas les fichiers de configuration sensibles à l'intérieur du répertoire racine du serveur web.
- Pour les serveurs Windows IIS, le répertoire racine du serveur web ne doit pas être situé sur le disque système, afin d'empêcher une traversée récursive vers les répertoires système.

Comment se protéger :
- Privilégiez de travailler sans entrée utilisateur lors de l'utilisation des appels au système de fichiers.
- Utilisez des index plutôt que des portions réelles de noms de fichiers lors de l'utilisation de modèles ou de fichiers de langue (par exemple, la valeur 5 provenant de la soumission de l'utilisateur = Tchécoslovaquie, plutôt que de s'attendre à ce que l'utilisateur retourne "Tchécoslovaquie").
- Assurez-vous que l'utilisateur ne peut pas fournir toutes les parties du chemin – entourez-le avec votre code de gestion des chemins.
- Validez l'entrée de l'utilisateur en n'acceptant que des données connues comme valides – ne vous contentez pas de nettoyer les données.
- Utilisez des environnements chrootés et des politiques d'accès au code pour restreindre les endroits où les fichiers peuvent être obtenus ou enregistrés.
- Si l'utilisation de l'entrée utilisateur pour des opérations sur des fichiers est inévitable, normalisez l'entrée avant de l'utiliser dans les API d'entrées/sorties de fichiers, comme normalize().

input validation example from [this repo](https://github.com/hu8813/42_darkly/tree/main/05-path-traverser/Resources) :
```php
// Unsafe code
include($_GET['page'] . '.php');

// Safe code
$whitelist = ['home', 'about', 'contact'];
$page = in_array($_GET['page'], $whitelist) ? $_GET['page'] : 'default';
include($page . '.php');
```

[Source OWASP](https://owasp.org/www-community/attacks/Path_Traversal)

## Reproduire la faille

C'est en manipulant le paramètre `page` de l'url que nous pouvons accéder à un fichier hors du répertoire www du serveur web.

En modifiant le chemin avec `?page=../`, en reculant d'un repertoire a chaque fois, nous avons pu voir les messages suivants :
"Wtf ?"
"Wrong.."
"Nope..
"Almost."
"Still nope.."
"Nope..
"You can DO it !!! :]"

```
http://localhost:4242/?page=../../../../../../../etc/passwd
```
`Congratulaton!! The flag is : b12c4b2cb8094750ae121a676269aa9e2872d07c06e429d25a63196ec1c8c1d0 `

Le contenu de /etc/passwd est révélé, le flag apparait dans une alerte JS.

Ceci explique la raison pour laquelle le projet se fait dans une VM :D.
