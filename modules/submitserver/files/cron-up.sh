#! /bin/ksh
/sbin/ifconfig "$1" addif "$2" netmask + deprecated up
/opt/ts/bin/cronie -n $(hostname)
