#!/bin/bash

export KF5_PREFIX=/opt/kf5

cat > ./kf5.sh << "EOF" &&
# Begin /etc/profile.d/kf5.sh

export KF5_PREFIX=/opt/kf5

pathappend $KF5_PREFIX/bin              PATH
pathappend $KF5_PREFIX/lib/pkgconfig    PKG_CONFIG_PATH

pathappend $KF5_PREFIX/etc/xdg          XDG_CONFIG_DIRS
pathappend $KF5_PREFIX/share            XDG_DATA_DIRS

pathappend $KF5_PREFIX/lib/plugins      QT_PLUGIN_PATH
pathappend $KF5_PREFIX/lib/plugins/kcms QT_PLUGIN_PATH

pathappend $KF5_PREFIX/lib/qml          QML2_IMPORT_PATH

pathappend $KF5_PREFIX/lib/python3.9/site-packages PYTHONPATH

pathappend $KF5_PREFIX/share/man        MANPATH
# End /etc/profile.d/kf5.sh
EOF

as_root mv -v ./kf5.sh /etc/profile.d/kf5.sh &&

cat >> ./qt5-add.sh << "EOF" &&
# Begin Qt5 changes for KF5

pathappend $QT5DIR/plugins             QT_PLUGIN_PATH
pathappend $QT5DIR/qml                 QML2_IMPORT_PATH

# End Qt5 changes for KF5
EOF

as_root mv -v ./qt5-add.sh /etc/profile.d/qt5.sh &&

cat >> ./kde.conf << "EOF" &&
# Begin KF5 addition

/opt/kf5/lib

# End KF5 addition
EOF

as_root mv -v ./kf5.conf /etc/ld.so.conf.d/ &&

as_root install -v -dm755           $KF5_PREFIX/{etc,share} &&
as_root ln -sfv /etc/dbus-1         $KF5_PREFIX/etc         &&
as_root ln -sfv /usr/share/dbus-1   $KF5_PREFIX/share

as_root install -v -dm755                $KF5_PREFIX/share/icons &&
as_root ln -sfv /usr/share/icons/hicolor $KF5_PREFIX/share/icons &&

cd /opt &&
if [ -d /opt/kf5 ]
 then
  as_root mv /opt/kf5{,-5.77.0}
fi
#as_root ln -sfv kf5-5.77.0 /opt/kf5
