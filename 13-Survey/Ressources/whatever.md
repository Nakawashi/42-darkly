# Input Validation


## URL

`/page=survey`

## Description

Selon l'OWASP, fait partie des risque de sécurité liés à la validation des entrées utilisateur.
Tentative d'envoyer des valeurs non autorisées qui peuvent être à risque.

[OWASP input validation attack Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html)

## Se protéger

Il est impératif de systématiquement valider toutes les données envoyées par le client du côté du client, mais également et surtout côté serveur. Le backend doit toujours savoir ce qu'il est censé recevoir.

## Reproduire la faille

Inspecter la page au niveau de la liste déroulante qui propose des valeurs de 1 à 10 :
```html
<option value="1">1</option>
...
<option value="10">10</option>
```
Ce sont des validations côté client, facilement contournables.
Changer la valeur de value pour dépasser 10 et inscrire cette valeur dans le texte de l'option. Choisir cette nouvelle option et envoyer le formulaire affichera le flag.