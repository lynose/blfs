#!/bin/bash

${log} `basename "$0"` " started" xorg &&
export XORG_PREFIX="/usr" &&
export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var --disable-static" &&

as_root cat > /etc/profile.d/xorg.sh << EOF
XORG_PREFIX="$XORG_PREFIX"
XORG_CONFIG="--prefix=\$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"
export XORG_PREFIX XORG_CONFIG
EOF

chmod 644 /etc/profile.d/xorg.sh &&

echo "$XORG_PREFIX/lib" >> /etc/ld.so.conf &&
sed "s@/usr/X11R6@$XORG_PREFIX@g" -i /etc/man_db.conf &&
#ln -svf $XORG_PREFIX/share/X11 /usr/share/X11 &&
ln -svf $XORG_PREFIX /usr/X11R6 &&

${log} `basename "$0"` " finished" xorg
