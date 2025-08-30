# Cross Site Scripting (XSS) : Reflected XSS via data URL injection.


## URL

`/index.php?page=media&src=nsa`

## Description

Les attaques **reflected** (réfléchies) se produisent lorsque le script injecté est renvoyé par le serveur web, par exemple dans un message d’erreur, un résultat de recherche ou toute réponse qui inclut une partie ou la totalité des données envoyées par l’utilisateur.

L’attaque est transmise à la victime par un autre canal, comme un e-mail ou un site web. Quand l’utilisateur clique sur un lien malveillant, soumet un formulaire ou visite un site compromis, le code injecté est envoyé au site vulnérable, qui le renvoie ensuite au navigateur de l’utilisateur. Le navigateur exécute le code en pensant qu’il provient d’un serveur de confiance.

Ce type de XSS est aussi appelé Non-Persistent ou Type-I XSS, car l’attaque se déroule sur un seul cycle requête/réponse.

Le problème vient du fait que le paramètre data (ici `src`) est directement utilisé pour **générer du contenu HTML dans la page sans aucune validation ni échappement**. Concrètement :

1. Le site accepte des URLs `data`:
	- `data:text/plain,…` ou `data:text/html,…`
	- Ces URLs permettent d’injecter du contenu directement dans la page.
	- Le navigateur interprète ce contenu comme s’il faisait partie de la page, donc un `<script>` est exécuté.

2. Aucune filtration des caractères spéciaux ou des balises HTML :
	- On peut mettre du JavaScript (`<script>alert(1)</script>`) ou encoder du contenu en Base64.
	- Le site ne bloque rien, donc l’attaquant peut injecter du code exécutable.

3. Impact :
	- Le paramètre `src` devient une **porte d’entrée pour XSS**.
	- Tout utilisateur qui charge cette URL risque d’exécuter du code malveillant.
	- Dans cet exemple, cela a permis de récupérer un **flag**, donc une donnée sensible normalement inaccessible.

## Se protéger

Préférer la méthode POST plutôt que GET pour ne pas afficher les paramètres dans l’url et toujours valider les entrées utilisateurs. Mécanisme d’authentification sur des ressources sensibles. Eviter d'utiliser la balise object et utiliser img à la place.

## Reproduire la faille

On a testé d'ajouter un script JS comme paramètre pour voir s'il allait être interprété : `?page=media&src=data:text/html,<script>alert(1)</script>`
Ce qui confirme que c'est bien le cas car affiche bien 1 dans une alert msg. </br>
On encode `<script>alert(1)</script>` en base64 ce texte pour retirer tout probleme lie aux caracteres speciaux :
`?page=media&src=data:text/html;base64,ICA8c2NyaXB0PiBhbGVydCgxKTwvc2NyaXB0PiAg`
Pourquoi base64 : ça permet d'avoir des caractères uniformes qui ne vont pas poser problème comme `=` ou `+` par exemple.
Notre code est exécuté et nous renvoie le flag.

[source Mozilla](https://developer.mozilla.org/fr/docs/web/http/basics_of_http/data_urls)
