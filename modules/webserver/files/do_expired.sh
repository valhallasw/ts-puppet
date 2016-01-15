#! /bin/ksh

set -e

DATE=$(date +%Y-%m-%d)
DAYS=$(date2days $DATE)
FILE=/etc/htaccess
MARKER='# Do not remove this line -- doexpired.sh requires it.'

sed "/$MARKER/,\$d" $FILE >$FILE.tmp
echo "$MARKER" >>$FILE.tmp

ldapsearch -h ldap -b o=unix,o=toolserver \
	"(&(objectclass=posixaccount)(&(shadowexpire<=$DAYS)(!(shadowexpire=$DAYS))))"	\
	uid |
	grep '^uid: ' |
	while read junk user; do
		echo >>$FILE.tmp "<Location /~$user/*>"
		echo >>$FILE.tmp "  Deny from all"
		echo >>$FILE.tmp "  ErrorDocument 404 /err/expired.php"
		echo >>$FILE.tmp "  ErrorDocument 403 /err/expired.php"
		echo >>$FILE.tmp "</Location>"
	done

mv $FILE.tmp $FILE

