#!/usr/bin/env ash

echo "Content-type: text/html"
echo ""


qrid=$(echo "$QUERY_STRING" | awk -F "=" '{ print $2 }')

dateloadpage=$(date +%s)

request="$(http --ignore-stdin "http://admin:admin@couchserver:5984/qrlive/$qrid")"

if [[ "$(echo "$request" | jq -r .error)" == "not_found" ]]; then
    response="Ошибка. Неверный ID - $qrid"

        else

        startlive="$(echo "$request" | jq -r .timestamp)"

let "timefailed=dateloadpage-startlive "

if [ $timefailed  -gt 240 ] ; then 

    response="Ошибка. QR од с ID $qrid устарел, а ты морковка"

    else
        response="ID $qrid прошел проверку"
        fi

fi

# отдаем пользователю html страницу, заменя переменные на реальные данные
cat /var/www/html/entrypoint.html | sed "s|QRCODEID|$response|g" 


#env


