#!/bin/sh
while [ $# -gt 0 ]
do
  case $1
  in
    -H)
      HOST=$2
      shift 2
    ;;


    -m)
      NAME=$2
      shift 2
    ;;

    *)
      echo "The arguments to use are"
      echo "-m: Virtual Machine Name "
      shift 1
      exit 0
    ;;
  esac
done
RETURN=0

ERROR=`xm list $NAME 2>&1 | grep Error `
if [ -n "$ERROR" ]; then
       echo "Unknown - Virtual System does not exist"
       exit 3
    fi
DATA=`xm list $NAME`
R=`xm list $NAME | tail -1 | cut -c 64`
B=`xm list $NAME | tail -1 | cut -c 65`
P=`xm list $NAME | tail -1 | cut -c 66`
S=`xm list $NAME | tail -1 | cut -c 67`
C=`xm list $NAME | tail -1 | cut -c 68`
D=`xm list $NAME | tail -1 | cut -c 69`

if [ $R == "r" ] || [ $B == "b" ]; then
        echo "OK - Virtual System is Up"
        exit 0
   fi

if [ $P == "p" ]; then
        echo "Warning - Virtual System is Paused"
        exit 1
   fi

if [ $S == "s" ] || [ $C == "c" ] || [ $D == "d" ]; then
        echo "Critical - Virtual System is Down"
        exit 2
   fi

echo ":$TYPE:$HOST:$WARN:$CRIT:"
echo 3

