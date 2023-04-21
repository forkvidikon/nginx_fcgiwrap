# Контейнер с nginx+fcgiwrap

## Для сборки используется комманда:


`
docker build -t mentainer/nginxfcgi:1 .
`

Имя образа замените на свое

### Запуск контенера

`docker run -d -p 80:80 -v \
./conf/nginx.conf:/etc/nginx/nginx.conf \
-v ./conf/http.d:/etc/nginx/http.d \
-v ./data:/var/sh/cgi \
-v ./html:/var/www/html \
--name vidikon_nginx vidikon/nginx:1`

Требуется также заменить имя контейнера и имя образа на свои имена

## Структура каталогов

- conf - конфигурация nginx
- data - скрипты bash
- html - статичные html файлы
- sh - скрипт для запуска в ENTRYPOINT docker'а

## Как проверить что все работает

Для этого собираем и запускаем контейнер. После чего по адресу

`ipaddress:port/index.html`

откроется простая веб-страница, а по запросу 

`ipaddress:port/cgi/index.sh`

будет выполнен наш скрипт, который находится в каталоге data