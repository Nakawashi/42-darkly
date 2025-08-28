# htpasswd

## URL

`http://192.168.1.70/whatever/`

## Description

`htpasswd` permet de créer et de maintenir les fichiers textes où sont stockés les noms d'utilisateurs et mots de passe pour l'authentification de base des utilisateurs HTTP.
`htpasswd` hache les mots de passe en utilisant bcrypt, une version de MD5 modifiée pour **Apache**
SHA-1 ou la routine système `crypt()`.

Cela signifie que l'on peut se connecter à des zones de notre serveur ou de nos applications qui nécessitent ce mot de passe.

## Se protéger

Faire rediriger ailleurs si un utilisateur tente d’accéder à un fichier non indexé.

## ## Reproduire la faille
Comment on a trouvé : fichier connu et faisant partie de tous les sites, il fallait tester.

```
Index of /whatever/

../
htpasswd                             29-Jun-2021 18:09                  38
```

On télécharge le fichier, contenu : `root:437394baff5aa33daa618be47b75cb49`

Le mot de passe dans ce fichier est chiffré en MD5.
Accéder à cette URL http://192.168.1.70/admin/ (à tout hasard et parce qu’on est des génies)

## Déchiffrer le flag
https://md5decrypt.net/#google_vignette pour déchiffrer le mot de passe `437394baff5aa33daa618be47b75cb49` ce qui nous donne `qwerty123@`