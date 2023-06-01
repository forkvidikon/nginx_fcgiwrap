#!/usr/bin/env ash



cookie_allow="$(echo $HTTP_COOKIE | awk -F "=" '{ print $2 }')"

if [[ "$cookie_allow" == "yes" ]];
    then
        echo "Content-type: text/html"
        echo ""
        cat /var/www/html/access.html
        env
    else

        echo "Content-type: text/html"
        echo ""
        echo '<head>   <meta http-equiv="refresh" content="0; URL=/cgi/index.sh" /> </head>'

fi