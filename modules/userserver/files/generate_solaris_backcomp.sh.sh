#!/bin/bash

COMMANDS="awk cat cut diff find grep less sed sort tar tee"
FILE="solaris_backcomp.sh"

rm "$FILE"

echo "#!/bin/bash">>"$FILE"
echo "#">>"$FILE"
echo "#To get some backcompatibily to the solaris-boxes.">>"$FILE"

for COMM in $COMMANDS
do
	echo "alias g${COMM}=\"$COMM\"">>"$FILE"
done

echo "">>"$FILE"
echo "alias cronie=\"crontab\"">>"$FILE"

echo "#EOF">>"$FILE"


#EOF
