#!/usr/bin/env ash


cookie_allow="$(echo $HTTP_COOKIE | awk -F "=" '{ print $2 }')"

# Проверяем, есть ли у нас qrallow пользователя
request="$(http --ignore-stdin "http://admin:admin@couchserver:5984/qrallow/$cookie_allow")"

if [[ "$(echo "$request" | jq -r .error)" == "not_found" ]];
    then
        echo "Content-type: text/html"
        echo ""
        echo '<head>   <meta http-equiv="refresh" content="0; URL=/cgi/index.sh" /> </head>'
    else

        echo "Content-type: text/html"
        echo ""
        cat /var/www/html/access.html
        env

fi