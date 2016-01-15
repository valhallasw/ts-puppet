#!/bin/bash
# -- This file is under puppet-control! --
#
# Measures the number of executed cronie-jobs.
#
# By DaB. <dab@toolserver.org>
# BSD-license.

TMPFILE=`mktemp`


if [ "$1" = "config" ]; then

	echo 'graph_title Number of cron-jobs.'
	echo 'graph_args --lower-limit 0'
	echo 'graph_category system'
	
	echo 'average.draw LINE2'
	echo 'average.label Average'
	
	echo 'max.draw LINE1'
	echo 'max.label Maximum'
	
	echo 'min.draw LINE1'
	echo 'min.label Minimum'
	
	echo 'errors.draw LINE2'
	echo 'errors.colour 000000'
	echo 'errors.label Errors'

exit 0
fi
                

OKSUM=0
ERRORSUM=0
for i in 4 3 2 1 0
do
	DATE=`LC_ALL=C /opt/ts/bin/gdate --date "$i minutes ago" '+%b %e %H:%M'`
	CRONLINES=`grep "${DATE}" /var/log/syslog|grep "/OPT/TS/SBIN/CROND"`
	
	OKVALUE=`echo "${CRONLINES}"|grep "CMD"|wc -l`
	ERRORVALUE=`echo "${CRONLINES}"|grep "cron.error"|wc -l`
	
	OKSUM=$[$OKSUM+$OKVALUE]
	ERRORSUM=$[$ERRORSUM+$ERRORVALUE]
	
	echo "$OKVALUE">>"${TMPFILE}"
done

AVERAGE=$[$OKSUM/5]
echo "average.value $AVERAGE"

LEAST=`cat "${TMPFILE}"|/opt/ts/bin/gsort -n|head -n 1`
echo "min.value $LEAST"

MOST=`cat "${TMPFILE}"|/opt/ts/bin/gsort -n|/opt/ts/bin/gtail -n 1`
echo "max.value $MOST"

echo "errors.value $[$ERRORSUM/5]"

rm -f "$TMPFILE"


#EOF
