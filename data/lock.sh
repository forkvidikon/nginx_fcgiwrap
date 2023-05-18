#! /bin/ash

#Создать файл блокировки
echo $1 > /var/www/html/qr.lock
#Подождать 180 секунд
sleep $2
# Удалить файл блокировки
rm /var/www/html/qr.lock

