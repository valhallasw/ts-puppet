#!/bin/bash

# Source the .environment-file in the userhome if it exists.

#if [[ -f "$HOME/.environment" ]]; then
#	RIGHTS=`stat --format=%a $HOME/.environment`
#	GRIGHT=`echo "$RIGHTS"|sed -e "s/^.//"|sed -e "s/.$//"`
#	ORIGHT=`echo "$RIGHTS"|sed -e "s/^..//"`
#	if [[ $GRIGHT -lt 5 && $ORIGHT -lt 5 ]]; then
#		. "$HOME/.environment"
#	else
#		echo "\"$HOME/.environment\" has wrong rights."|/usr/bin/logger
#	fi
#fi

#EOF