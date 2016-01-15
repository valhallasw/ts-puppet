#!/bin/sh

# Print quota information if quota exceeded.
[ -z "$(quota -q)" ] || quota -sv

#EOF
