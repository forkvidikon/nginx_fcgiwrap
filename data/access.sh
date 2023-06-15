#!/usr/bin/env ash


cookie_allow="$(echo $HTTP_COOKIE | awk -F "=" '{ print $2 }')"
llc="$(echo $HTTP_COOKIE | awk -F "=" '{ print $1 }')"

qr_allow_request="$(http --ignore-stdin "http://admin:admin@192.168.122.207:5984/qrallow/$cookie_allow")"

# Проверяем, есть ли у нас qrallow пользователя
if [[ "$(echo "$qr_allow_request" | jq -r .error)" == "not_found" ]];
    then
        echo "Content-type: text/html"
        echo ""
        echo '<head>   <meta http-equiv="refresh" content="0; URL=/cgi/index.sh" /> </head>'
    else

        echo "Content-type: text/html"
        # Долгоживущая кука, чтобы человек не мог отметиться за других, кодируем base64
        echo "Set-Cookie: llc=aHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj1GVHVfbmRuaC13YyZhYl9jaGFubmVsPSVEMCU5MCVEMCVCQiVEMCVCNSVEMCVCQSVEMSU4MSVEMCVCNSVEMCVCOSVEMCU5RiVEMCVCNSVEMSU4MiVEMSU4MCVEMCVCRSVEMCVCMg==); expires=$(date -d '+12 hour' '+%a, %d %b %Y %H:%M:%S %Z'))"
        echo ""
        cat /var/www/html/access.html
        env


fi
