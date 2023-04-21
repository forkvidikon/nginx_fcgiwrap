#!/usr/bin/env ash

echo "Content-type: text/html"
echo ""

#Заглушка - имя изображения, содержащего qr код
imagename="qrcode.png"

# Заглушка - страница, на которую переходит пользователь после сканирования кода
autchPage="auth.html"

# Генерируем qr код
qrencode -d 320 -s 6 -l H -o "/var/www/html/img/$imagename" "http://$HTTP_HOST/cgi/index.sh"

# отдаем пользователю html страницу, заменя переменные на реальные данные
cat /var/www/html/qr.html | sed "s|QRCODE_SECTION|/img/$imagename|g" | sed "s|QR_PAGE_AUTH|$autchPage|g"


