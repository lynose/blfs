#!/bin/bash

${log} `basename "$0"` " started" xorg &&
export XORG_PREFIX="/usr" &&
export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var --disable-static" &&

cat > ./xorg.sh << EOF
XORG_PREFIX="$XORG_PREFIX"
XORG_CONFIG="--prefix=\$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"
export XORG_PREFIX XORG_CONFIG
EOF

as_root mv -v ./xorg.sh /etc/profile.d/xorg.sh &&

as_root chmod 644 /etc/profile.d/xorg.sh &&

echo "$XORG_PREFIX/lib" >> /tmp/xorg.conf &&
as_root mv -v /tmp/xorg.conf /etc/ld.so.conf.d/xorg.conf
as_root sed "s@/usr/X11R6@$XORG_PREFIX@g" -i /etc/man_db.conf &&
${log} `basename "$0"` " finished" xorg
