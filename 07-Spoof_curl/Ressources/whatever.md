# HTTP header injection


## URL

Page du copyright (l'aigle)
`/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f`

## Description

Le *HTTP Response Splitting* se produit lorsque :

Des données provenant d'une source non fiable (souvent une requête HTTP) sont envoyées à une application web.

Ces données sont incluses dans un en-tête de réponse HTTP envoyé à l'utilisateur sans validation pour détecter des caractères malveillants.

Le HTTP response splitting est un moyen permettant à un attaquant de manipuler les en-têtes et le corps de la réponse HTTP d'une application vulnérable. L'attaque fonctionne de manière simple : l'attaquant envoie des données malveillantes à une application vulnérable, et cette dernière inclut ces données dans la réponse HTTP.

Pour que l'attaque soit réussie, l'application doit permettre l'injection de caractères CR (retour chariot, représenté par %0d ou \r) et LF (saut de ligne, représenté par %0a ou \n) dans l'en-tête de la réponse. Ces caractères permettent à l'attaquant de contrôler les en-têtes et le corps de la réponse, et d'ajouter des réponses supplémentaires entièrement sous leur contrôle.

Un exemple Java montre ce problème, mais il a été corrigé dans la plupart des serveurs d'applications Java EE modernes. Si vous êtes préoccupé par ce risque, il est recommandé de tester la plateforme concernée pour vérifier si elle autorise l'injection de ces caractères dans les en-têtes.

Résumé :
Le HTTP response splitting est une vulnérabilité où un attaquant peut injecter des caractères malveillants dans un en-tête HTTP, créant ainsi des en-têtes ou des réponses supplémentaires sous son contrôle. Cela se produit lorsque l'application web ne valide pas correctement les données d'entrée. La vulnérabilité a été largement corrigée dans les serveurs d'applications modernes.

[OWASP source](https://owasp.org/www-community/attacks/HTTP_Response_Splitting)

### Rappels

**Referer** : Cet en-tête HTTP indique la page précédente à partir de laquelle une requête a été faite. Par exemple, si un utilisateur clique sur un lien pour accéder à une nouvelle page, l'URL de la page d'origine sera envoyée via l'en-tête `Referer`.

**User-Agent** : Cet en-tête HTTP fournit des informations sur le navigateur ou l'application client utilisée par l'utilisateur pour accéder au site. Il peut inclure des détails comme le type de navigateur, la version, et parfois le système d'exploitation.


## Se protéger

- Les headers ne sont pas une source fiable
- Contrôler les accès avec des sessions et tokens

## Reproduire la faille

Inspecter la page et trouver le commentaire.
Il est question du
- Referer `https://www.nsa.gov`
- User-Agent `ft_bornToSec`

On peut tester avec cURL en indiquant l'ip :
```shell
curl "http://<IP_ADDRESS>/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f" \
  --user-agent "ft_bornToSec" \
  --referer "https://www.nsa.gov/"
```
