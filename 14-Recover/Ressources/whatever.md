# Web Parameter Tampering

## URL

Formulaire de login `/?page=recover`

## Description

[Source OWASP Hidden field manipulation vulnerability](https://owasp.org/www-community/attacks/Web_Parameter_Tampering)

## Se protéger

Voici quelques propositions pour se protéger des manipulations de paramètres web :

- L'utilisateur doit faire attention aux données qu'il inscrit dans un formulaire, l'auto-complétion peut remplir des champs cachés.
- Valider et filtrer les données reçues côté serveur
- Utiliser des valeurs non modifiables
- Chiffrer ou signer les paramètres sensibles
- Contrôle d'accès et d'actions
- Limiter les privilèges des utilisateurs
- Surveiller les logs
- Faire des tests d'injection, des audits de vulnérabilités


## ## Reproduire la faille

Un champ caché se trouve sur la page de récupération de mot de passe. Il permet de définir une adresse email d'administrateur.
Nous, on a inspecté la page et vu un `<input type=hidden ... >` avec comme valeur "webmaster", on en a déduis que c'était l'email qui allait recevoir le nouveau mot de passe.