#!/bin/bash

export PLASMA_PREFIX=/opt/plasma-5.21

cat > /tmp/plasma.sh << "EOF" &&
# Begin /etc/profile.d/plasma.sh

export PLASMA_PREFIX=/opt/plasma-5.21

pathappend $PLASMA_PREFIX/bin              PATH
pathappend $PLASMA_PREFIX/lib/pkgconfig    PKG_CONFIG_PATH

pathappend $PLASMA_PREFIX/etc/xdg          XDG_CONFIG_DIRS
pathappend $PLASMA_PREFIX/share            XDG_DATA_DIRS

pathappend $PLASMA_PREFIX/lib/plugins      QT_PLUGIN_PATH
pathappend $PLASMA_PREFIX/lib/plugins/kcms QT_PLUGIN_PATH

pathappend $PLASMA_PREFIX/lib/qml          QML2_IMPORT_PATH

pathappend $PLASMA_PREFIX/lib/python3.9/site-packages PYTHONPATH

pathappend $PLASMA_PREFIX/share/man        MANPATH
# End /etc/profile.d/plasma.sh
EOF

as_root mv -v /tmp/plasma.sh /etc/profile.d/plasma.sh &&

cat >> /tmp/plasma.conf << "EOF" &&
# Begin PLASMA addition

/opt/plasma/lib

# End KDE addition
EOF
as_root mv -v /tmp/plasma.conf /etc/ld.so.conf.d/ &&




