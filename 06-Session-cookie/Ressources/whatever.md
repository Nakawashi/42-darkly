# Cookie Theft Mitigation


## URL

Pas d'url, mais on inspecte n'importe quelle page du site, voir plus bas la partie "Reproduire la faille".

## Description

Session Cookies are given to users when they log in. If these are stolen by an attacker and used to hijack the session from the attacker's device, certain environment information used in the connection for session will change.

For example, if stolen cookies are used by an attacker from another country, you can detect this by detecting a significant change in the IP address.

In this way, there are multiple vectors that can be used to detect that the user environments has changed.

- Access from different region (IP Address)
- Access from different device (User-Agent)
- Access from different language setting (Accept-Language)
- Access at different time of day (Date)

If you save this information when establishing a session and compare it in each request, you can detect if the user environment has changed.

Of course, it is difficult to make a judgment based on simple comparison alone. For example, if the user changes the Wi-Fi network they are connected to, their IP address will change. If the user updates their browser, User-Agent will change. So it is necessary not only to compare the values, but also to check whether the meaning of the values has not changed significantly.

[Source OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Cookie_Theft_Mitigation_Cheat_Sheet.html)

## Se protéger

Pour se protéger contre le vol de cookies, il est essentiel de détecter rapidement toute anomalie dans l'environnement de l'utilisateur. Cela inclut la surveillance de changements significatifs dans l'adresse IP, le type de navigateur (User-Agent), la langue acceptée (Accept-Language) et la date/heure des connexions. Ces informations doivent être collectées lors de l'établissement de la session et comparées à chaque nouvelle requête.

En cas de détection d'une anomalie, une vérification de la session est recommandée. Cela peut inclure une nouvelle authentification de l'utilisateur ou l'utilisation de mécanismes tels qu'un CAPTCHA pour confirmer l'identité. Il est important de noter que ces méthodes peuvent entraîner des faux positifs ou des faux négatifs, il convient donc de les utiliser avec discernement.

Enfin, pour renforcer la sécurité, il est conseillé de lier les identifiants de session à des informations spécifiques à l'appareil ou à l'utilisateur, comme l'adresse MAC ou l'empreinte du périphérique. Cela rend plus difficile pour un attaquant d'exploiter un cookie volé, même s'il parvient à le récupérer.

## Reproduire la faille et déchiffrer le flag

Inspecter une page web

FF : onglet stockage
Chrome : onglet Storage

On regarde les cookies, récupère la valeur pour I_am_admin : `68934a3e9455fa72420237eb05902327`
Déchiffrer avec MD5 et on obtient **false**
On chiffre **true** avec MD5 et on obtient `b326b5062b2f0e69046810717534cb09`.
On remplace l'ancienne valeur du cookie avec celle-ci, on navigue vers une autre page ou on recharge la page et le flag s'affiche dans une alert JS.
