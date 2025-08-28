# Brute Force Attack

## URL

`/index.php?page=signin`

## Description

Une attaque par force brute consiste à envoyer des requêtes avec des valeurs prédéfinies à un serveur et à analyser les réponses.
L'attaquant peut utiliser un dictionnaire ou une méthode traditionnelle, et calculer le temps nécessaire pour tester toutes les valeurs selon l'efficacité des systèmes impliqués.

Cette faille est souvent utilisée pour permettre de récupérer des moyen d'authentifications et des contenus ou pages cachés dans une application web.
Les requêtes HTTP `GET` et `POST` sont le plus souvent utilisés pour cela.

[Lien OWASP bruteforce attack](https://owasp.org/www-community/attacks/Brute_force_attack)

## Se protéger

Le "login throttling" (limitation de connexions) est un protocole qui permet de prévenir ce genre d'attaques, en limitant le nombre de tentatives de connexions, de requêtes, pour tenter de trouver un mot de passe.
Avoir un mot de passe avec une politique de sécurité sérieuse, se protéger contre le spam (captcha, check anti robot).

[Lien OWASP login throttling](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html#account-lockout)

## ## Reproduire la faille

C’est connu alors on a cherché un moyen d’avoir une liste de mots de passes fréquemment utilisés. Le serveur n'impose pas de limites de requêtes.
Ce qu’on veut faire : trouver un moyen de s’authentifier

Solution : bruteforce

- Etape 1 : trouver un login pour pouvoir sign in  —> voir dans les cookies, on trouve I_am_admin (mais au final y’a pas de login)
- Etape 2 : récupérer le fichier rockyou.txt avec tous les mots de passes à tester
- Etape 3 : lancer le script bash
- Etape 4 se loguer (sans login, mot de passe = shadow)

