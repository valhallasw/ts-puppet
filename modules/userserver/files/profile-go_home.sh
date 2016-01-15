#!/bin/bash

# Sends the user to its home if requested. Mostly needed by our sudo-
# system.

if [[ "$GOINTOHOME" == "YES" ]]; then
	cd "$HOME"
fi

#EOF