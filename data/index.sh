#!/usr/bin/env ash

echo "Content-type: text/html"
echo ""

#Заглушка - имя изображения, содержащего qr код
imagename="qrcode.png"

# Заглушка - страница, на которую переходит пользователь после сканирования кода
autchPage="entrypoint.sh"




    # Провека на существование файла блокировки
    if ! [ -f /var/www/html/qr.lock ]; then

        # Количество секунд с начала эпохи
        dategenqr=$(date +%s)

        #Количество секунд, в течение которых нельзя создать новый qr код
        block=180

        
        # Вызвать скрипт, блокирующий создание нового qr кода на 180 секунд
        # nohup позволяет запустить скрипт, заблокировав некоторые системные сигналы
        # то есть вложенный скрипт не завершится при завершении работы основного
        # сивол & указываемый после команды отправляет задачу в фон
        # Почему же нельзя просто использовать & для запуска задачи в фоне?
        # Потому что после завершения работы основного скрипта происходит выход из оболочки
        # который завершает дочерние фоновые задачи. Чтобы избежать этого мы и используем nohup
        # &>/dev/null используется для подавления любого вывода, чтобы он случайно не оказался на сайте
        nohup /var/sh/cgi/./lock.sh $dategenqr $block &>/dev/null &
        #Ссылка для qr-кода
        link=$(echo "http://$HTTP_HOST/cgi/$autchPage?qrid=$RANDOM")

        # Генерируем qr код
        qrencode -d 320 -s 6 -l H -o "/var/www/html/img/$imagename" "$link"
        
    fi

# отдаем пользователю html страницу, заменя переменные на реальные данные
cat /var/www/html/qr.html | sed "s|QRCODE_SECTION|/img/$imagename|g" | sed "s|QR_PAGE_AUTH|$autchPage|g"
# env
# echo  " date=$dategenqr"



