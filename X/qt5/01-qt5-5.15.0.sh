#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/qt-everywhere-src-5.15.0
 then
  rm -rf /sources/qt-everywhere-src-5.15.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.qt.io/archive/qt/5.15/5.15.0/single/qt-everywhere-src-5.15.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-qt5 &&

tar xf /sources/qt-everywhere-src-5.15.0.tar.xz -C /sources/ &&

cd /sources/qt-everywhere-src-5.15.0 &&

export QT5PREFIX=/opt/qt5 &&

mkdir /opt/qt-5.15.0
ln -sfnv qt-5.15.0 /opt/qt5

sed -i 's/python /python3 /' qtdeclarative/qtdeclarative.pro \
                             qtdeclarative/src/3rdparty/masm/masm.pri &&

./configure -prefix $QT5PREFIX                        \
            -sysconfdir /etc/xdg                      \
            -confirm-license                          \
            -opensource                               \
            -dbus-linked                              \
            -openssl-linked                           \
            -system-harfbuzz                          \
            -system-sqlite                            \
            -nomake examples                          \
            -no-rpath                                 \
            -skip qtwebengine  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&

QT5BINDIR=$QT5PREFIX/bin &&

as_root install -v -dm755 /usr/share/pixmaps/                  &&

as_root install -v -Dm644 qttools/src/assistant/assistant/images/assistant-128.png \
                  /usr/share/pixmaps/assistant-qt5.png &&

as_root install -v -Dm644 qttools/src/designer/src/designer/images/designer.png \
                  /usr/share/pixmaps/designer-qt5.png  &&

as_root install -v -Dm644 qttools/src/linguist/linguist/images/icons/linguist-128-32.png \
                  /usr/share/pixmaps/linguist-qt5.png  &&

as_root install -v -Dm644 qttools/src/qdbus/qdbusviewer/images/qdbusviewer-128.png \
                  /usr/share/pixmaps/qdbusviewer-qt5.png &&

as_root install -dm755 /usr/share/applications &&

as_root cat > /usr/share/applications/assistant-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Assistant
Comment=Shows Qt5 documentation and examples
Exec=$QT5BINDIR/assistant
Icon=assistant-qt5.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Documentation;
EOF

as_root cat > /usr/share/applications/designer-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Designer
GenericName=Interface Designer
Comment=Design GUIs for Qt5 applications
Exec=$QT5BINDIR/designer
Icon=designer-qt5.png
MimeType=application/x-designer;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF

as_root cat > /usr/share/applications/linguist-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Linguist
Comment=Add translations to Qt5 applications
Exec=$QT5BINDIR/linguist
Icon=linguist-qt5.png
MimeType=text/vnd.trolltech.linguist;application/x-linguist;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF

as_root cat > /usr/share/applications/qdbusviewer-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 QDbusViewer
GenericName=D-Bus Debugger
Comment=Debug D-Bus applications
Exec=$QT5BINDIR/qdbusviewer
Icon=qdbusviewer-qt5.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Debugger;
EOF

for file in moc uic rcc qmake lconvert lrelease lupdate; do
  as_root ln -sfrvn $QT5BINDIR/$file /usr/bin/$file-qt5
done

as_root cat >> /etc/ld.so.conf << EOF
# Begin Qt addition

/opt/qt5/lib

# End Qt addition
EOF

ldconfig

as_root cat > /etc/profile.d/qt5.sh << "EOF"
# Begin /etc/profile.d/qt5.sh

QT5DIR=/opt/qt5

pathappend $QT5DIR/bin           PATH
pathappend $QT5DIR/lib/pkgconfig PKG_CONFIG_PATH

export QT5DIR

# End /etc/profile.d/qt5.sh
EOF

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
