#!/bin/ash


echo "Content-type: text/html"
echo ""


#Заглушка - имя изображения, содержащего qr код
imagename="qrcode.png"

# Заглушка - страница, на которую переходит пользователь после сканирования кода
autchPage="entrypoint.sh"


        # Создать базу, в которой будем отслеживать qr-коды. Если уже существует, то создана не будет
     #   http PUT "http://admin:admin@couchserver:5984/qrlive"


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
        qrcodeid="$RANDOM"
        link=$(echo "http://$HTTP_HOST/cgi/$autchPage?qrid=$qrcodeid")

        # Генерируем qr код
        qrencode -d 320 -s 6 -l H -o "/var/www/html/img/$imagename" "$link"



       http --ignore-stdin -q PUT "http://admin:admin@couchserver:5984/qrlive/$qrcodeid"  timestamp="$dategenqr"
      

        
    fi

# отдаем пользователю html страницу, заменя переменные на реальные данные
cat /var/www/html/qr.html | sed "s|QRCODE_SECTION|/img/$imagename|g" | sed "s|QR_PAGE_AUTH|$autchPage|g"
env
echo  " date=$dategenqr"



