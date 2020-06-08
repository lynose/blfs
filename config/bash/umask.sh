#!/bin/bash

${log} `basename "$0"` " started" config &&
cat > /etc/profile.d/umask.sh << "EOF"
# By default, the umask should be set.
if [ "$(id -gn)" = "$(id -un)" -a $EUID -gt 99 ] ; then
  umask 002
else
  umask 022
fi
EOF

${log} `basename "$0"` " end" config 
