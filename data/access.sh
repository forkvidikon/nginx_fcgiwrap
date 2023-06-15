#!/usrbin/env ash

coockie_allow="$(echo $HTTP_COOKIE | awk -F "=" '{ print $2 }')"
if [["$cookie_allow" == "yes"]];
	then
		echo "Content-type: text/html"
		echo ""
		cat /var/www/html/acces.html
		env
		echo "Set-Cookie:longcookie=let($(date +%s)/ $RANDOM), max-age=43200"
	else
		echo ("!!!")
fi
