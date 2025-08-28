# # cURL Content-Type Spoofing


## URL

`/index.php?page=upload`

## Description

Technique d'attaque où un attaquant manipule le Content-Type d'une requête HTTP envoyée via l'outil cURL (ou d'autres outils similaires) pour tromper le serveur ou l'application cible.

Lorsqu'un client envoie une requête HTTP (par exemple, pour télécharger un fichier ou soumettre un formulaire), il peut spécifier un en-tête `Content-Type pour` indiquer le type de données qu'il envoie (comme `application/json`, `multipart/form-data`, `text/plain`, etc.).

Le Content-Type Spoofing se produit lorsque l'attaquant modifie cet en-tête pour le faire correspondre à un type de contenu que le serveur attend, alors qu'en réalité, le corps de la requête contient des données d'un autre type. Par exemple, l'attaquant pourrait essayer de soumettre un fichier malveillant en manipulant le `Content-Type` pour qu'il soit vu comme une image (comme `image/png` ou `image/jpeg`), alors que le contenu réel du fichier pourrait être un script PHP ou un autre code malveillant.

Sur notre site :
Seuls les fichiers .jpg et .jpeg sont autorisés.
L'application vérifie les extensions, pas le contenu.
Le fichier ne doit juste pas être vide.

## Se protéger

- Validation stricte du contenu des fichiers : analyser le fichier avec sa signature MIME ou son contenu binaire avec `finfo_file()` en PHP.
- Faire une liste blanche des Content-Type autorisés et connus comme `image/png`, `image/jpeg`...
- Renommer et déplacer les fichiers reçus dans un répertoire non accessible depuis le site, afin de les protéger contre une tentative de les exécuter sur le serveur depuis le client.
- Ré-encoder les images sur le serveur
- Vérifier que le Content-Type corresponde au contenu, appliquer une politique de sécurité stricte.

## Reproduire la faille

Seuls les fichiers .jpg et .jpeg sont autorisés.
L'application vérifie les extensions, pas le contenu.
Le fichier ne doit juste pas être vide.

## Déchiffrer le flag
... ?