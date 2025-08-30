# Open Redirect

## URL

Page d'accueil

## Description

La fonctionnalité de redirection du site permet à n'importe qui d'envoyer les utilisateurs vers n'importe quel lien externe en modifiant le paramètre `site` de l'url, sans qu'aucune vérification ne soit effectuée.


[Source OWASP redirections](https://cheatsheetseries.owasp.org/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.html)

## Se protéger

- **Validation des URLs de redirection** : Assurez-vous que les URLs de redirection pointent uniquement vers des destinations de confiance. Vous pouvez par exemple valider les domaines autorisés ou interdire les redirections vers des sites externes.
- **Utilisation de listes blanches** : Limitez les destinations de redirection à des URLs internes ou à un ensemble défini de domaines de confiance.
- **Encodage des URLs** : Vous pouvez également encoder les URLs de manière à empêcher la manipulation facile des paramètres.
- **Informer l'utilisateur** : Avant de rediriger, assurez-vous que l'utilisateur est bien informé du site vers lequel il est dirigé, afin qu'il puisse prendre une décision éclairée.

## Reproduire la faille

Inspecter les logos des réseaux sociaux.
Le lien de redirection est visible côté frontend et rien ne nous empêche de le modifier.
Cliquer sur le nouveau lien affiche le flag.

Exemple de lien derrière le réseau social Facebook :
```
index.php?page=redirect&site=facebook
```

Si on le modifie :
```
index.php?page=redirect&site=https://www.ouaismaisbon.ch/
```

Cliquer sur le nouveau lien affiche le flag.
