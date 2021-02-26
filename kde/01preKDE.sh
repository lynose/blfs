#!/bin/bash

export KDE_PREFIX=/opt/kde-20.12.2

if [ ! -d ${KDE_PREFIX} ]
  then 
    mkdir ${KDE_PREFIX}
fi

if [ -L /opt/kde ]
  then 
    rm /opt/kde
fi
as_root ln -s ${KDE_PREFIX} /opt/kde &&

cat > /tmp/kde.sh << "EOF" &&
# Begin /etc/profile.d/kde.sh

export KDE_PREFIX=/opt/kde-20.12.2

pathappend $KDE_PREFIX/bin              PATH
pathappend $KDE_PREFIX/lib/pkgconfig    PKG_CONFIG_PATH

pathappend $KDE_PREFIX/etc/xdg          XDG_CONFIG_DIRS
pathappend $KDE_PREFIX/share            XDG_DATA_DIRS

pathappend $KDE_PREFIX/lib/plugins      QT_PLUGIN_PATH
pathappend $KDE_PREFIX/lib/plugins/kcms QT_PLUGIN_PATH

pathappend $KDE_PREFIX/lib/qml          QML2_IMPORT_PATH

pathappend $KDE_PREFIX/lib/python3.9/site-packages PYTHONPATH

pathappend $KDE_PREFIX/share/man        MANPATH
# End /etc/profile.d/kde.sh
EOF

as_root mv -v /tmp/kde.sh /etc/profile.d/kde.sh &&

cat >> /tmp/kde.conf << "EOF" &&
# Begin KDE addition

/opt/kde/lib

# End KDE addition
EOF
as_root mv -v /tmp/kde.conf /etc/ld.so.conf.d/ 



