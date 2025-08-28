#!/bin/bash

baseUrl="http://192.168.1.70/.hidden/"

chercher_flag(){
    local url="$1"

    echo "Visite de : $url"

    contenu=$(curl -s "$url")

    liens=$(echo "$contenu" | grep -o 'href="[A-Za-z]*' | sed 's/href="//')

    for lien in $liens; do
        if [ "$lien" == "README" ]; then
            readme_content=$(curl -s "$url$lien")


            if echo "$readme_content" | grep -q "flag"; then
                echo -e "\nFLAG trouvé dans $url$lien :\n"
                echo "$readme_content"
                exit 0
            fi
        elif [ "$lien" != "" ]; then

            chercher_flag "$url$lien/"
        fi
    done
}

chercher_flag "$baseUrl"

echo -e "\nAucun FLAG trouvé."