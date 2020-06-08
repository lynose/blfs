#!/bin/bash
${log} `basename "$0"` " started" config &&

cat > /etc/profile.d/i18n.sh << "EOF"
# Set up i18n variables
. /etc/locale.conf
export LANG
EOF

${log} `basename "$0"` " end" config
