# htpasswd

## URL

`/robots.txt`
```
User-agent: *
Disallow: /whatever <<--- celui-ci
Disallow: /.hidden
```


## Description

`htpasswd` permet de créer et de maintenir les fichiers textes où sont stockés les noms d'utilisateurs et mots de passe pour l'authentification de base des utilisateurs HTTP.
`htpasswd` hache les mots de passe en utilisant bcrypt, une version de MD5 modifiée pour **Apache**
SHA-1 ou la routine système `crypt()`.

Cela signifie que l'on peut se connecter à des zones de notre serveur ou de nos applications qui nécessitent ce mot de passe.

## Se protéger

Faire rediriger ailleurs si un utilisateur tente d’accéder à un fichier non indexé.
Aussi, indiquer dans le fichier robots.txt le nom des fichiers sensibles les mets en lumiere ce qui n'est pas tres malin.

## ## Reproduire la faille

acceder a :
```
/whatever/htpasswd
```
telecharge le fichier htpasswd qui contient :
```
root:437394baff5aa33daa618be47b75cb49
```

Le mot de passe dans ce fichier est chiffré en MD5.
Accéder à cette URL http://<URL>/admin/ (à tout hasard et parce qu’on est des génies)
login : root
password : qwerty123@

## Déchiffrer le flag
[md5decrypt](https://md5decrypt.net/#google_vignette) pour déchiffrer le mot de passe `437394baff5aa33daa618be47b75cb49` ce qui nous donne `qwerty123@`
