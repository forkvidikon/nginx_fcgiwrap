#!/usr/bin/env ash


qrid=$(echo "$QUERY_STRING" | awk -F "=" '{ print $2 }')

dateloadpage=$(date +%s)

request="$(http --ignore-stdin "http://admin:admin@couchserver:5984/qrlive/$qrid")"

if [[ "$(echo "$request" | jq -r .error)" == "not_found" ]]; then
    response="Ошибка. Неверный ID - $qrid"

    echo "Content-type: text/html"
    echo ""
    cat /var/www/html/entrypoint.html | sed "s|QRCODEID|$response|g" | sed "s|STUDENTFORM||g"

        else

        startlive="$(echo "$request" | jq -r .timestamp)"

let "timefailed=dateloadpage-startlive "

if [ $timefailed  -gt 240 ] ; then 

    response="Ошибка. QR од с ID $qrid устарел, а ты морковка"
    
    
    echo "Content-type: text/html"
    echo ""
    cat /var/www/html/entrypoint.html | sed "s|QRCODEID|$response|g" | sed "s|STUDENTFORM||g"

    else
        response="ID $qrid прошел проверку"
        # отдаем пользователю html страницу, заменя переменные на реальные данные
        
        studentform="$(cat /var/www/html/template/studentform.html)"
        echo "Content-type: text/html"
        echo "Set-Cookie: qrallow=yes;  max-age=180"
        echo ""
        cat /var/www/html/entrypoint.html | sed "s|QRCODEID|$response|g" | sed "s|<!--form||g" | sed "s|form-->||g"

        fi

fi





#env


