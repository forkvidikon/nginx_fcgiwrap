#!/usr/bin/env ash



cookie_allow="$(echo $HTTP_COOKIE | awk -F "=" '{ print $2 }')"

if [[ "$cookie_allow" == "yes" ]];
    then
#qrid=$(echo "$QUERY_STRING" | awk -F "=" '{ print $2 }')
#dateloadpage=$(date +%s)
#request="$(http --ignore-stdin "http://admin:admin@couchserver:5984/qrlive/$qrid")"
        echo "Content-type: text/html"
        echo ""
        cat /var/www/html/access.html
        env
    else

        echo "Content-type: text/html"
        echo ""
        echo '<head>   <meta http-equiv="refresh" content="0; URL=/cgi/index.sh" /> </head>'

fi  




