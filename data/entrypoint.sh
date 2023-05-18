#!/usr/bin/env ash

echo "Content-type: text/html"
echo ""


qrid=$(echo "$QUERY_STRING" | awk -F "=" '{ print $2 }')


# отдаем пользователю html страницу, заменя переменные на реальные данные
cat /var/www/html/entrypoint.html | sed "s|QRCODEID|$qrid|g" 


env


