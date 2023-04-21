# Указываем референсный образ
FROM alpine:3.17
# Меняем зеркало репозитория на яндекс. Шаг не обязательный, у меня есть проблемы с доступом к стандартному репозиторию
RUN echo "https://mirror.yandex.ru/mirrors/alpine/v3.17/main" > /etc/apk/repositories
# Устанавливаем nginx и fcgiwrap
RUN  apk add  --no-cache nginx fcgiwrap
# Закидываем внутрь контейнера скрипт который делает всякие полезные штуки (читай коментарии в скрипте). Запекаем его в образе
COPY sh/service.sh /service.sh
# И задаем ему права на исполнение
RUN chmod +x /service.sh 
# Точка запуска контенера - скрипт который мы пробросили выше
ENTRYPOINT ["ash","/service.sh"]
