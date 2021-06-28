#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/qt-everywhere-src-5.15.2
 then
  rm -rf /sources/qt-everywhere-src-5.15.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.qt.io/archive/qt/5.15/5.15.2/single/qt-everywhere-src-5.15.2.tar.xz \
    /sources &&
check_and_download https://www.linuxfromscratch.org/patches/blfs/svn/qt-everywhere-src-5.15.2-CVE-2021-3481-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-qt5 &&

tar xf /sources/qt-everywhere-src-5.15.2.tar.xz -C /sources/ &&

cd /sources/qt-everywhere-src-5.15.2 &&

export QT5PREFIX=/opt/qt5 &&

as_root mkdir -p /opt/qt-5.15.2 &&
as_root ln -sfnv qt-5.15.2 /opt/qt5 &&

patch -Np1 -i ../qt-everywhere-src-5.15.2-CVE-2021-3481-1.patch &&

sed -i '/utility/a #include <limits>'     qtbase/src/corelib/global/qglobal.h         &&
sed -i '/string/a #include <limits>'      qtbase/src/corelib/global/qfloat16.h        &&
sed -i '/qbytearray/a #include <limits>'  qtbase/src/corelib/text/qbytearraymatcher.h &&
sed -i '/type_traits/a #include <limits>' qtdeclarative/src/qmldebug/qqmlprofilerevent_p.h &&

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

as_root find $QT5PREFIX/ -name \*.prl \
   -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' {} \; &&

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

cat > ./assistant-qt5.desktop << EOF &&
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

as_root install -m644 ./assistant-qt5.desktop /usr/share/applications/assistant-qt5.desktop &&

cat > ./designer-qt5.desktop << EOF &&
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

as_root install -m644 ./designer-qt5.desktop /usr/share/applications/designer-qt5.desktop &&

cat > ./linguist-qt5.desktop << EOF &&
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

as_root install -m644 ./linguist-qt5.desktop /usr/share/applications/linguist-qt5.desktop &&

cat > ./qdbusviewer-qt5.desktop << EOF &&
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

as_root install -m644 ./qdbusviewer-qt5.desktop /usr/share/applications/qdbusviewer-qt5.desktop &&

for file in moc uic rcc qmake lconvert lrelease lupdate; do
  as_root ln -sfrvn $QT5BINDIR/$file /usr/bin/$file-qt5
done

cat >> ./qt.conf << EOF &&
# Begin Qt addition

/opt/qt5/lib

# End Qt addition
EOF

as_root install -m644 ./qt.conf /etc/ld.so.conf.d/ &&

as_root ldconfig &&

cat > ./qt5.sh << "EOF" &&
# Begin /etc/profile.d/qt5.sh

QT5DIR=/opt/qt5

pathappend $QT5DIR/bin           PATH
pathappend $QT5DIR/lib/pkgconfig PKG_CONFIG_PATH

export QT5DIR

# End /etc/profile.d/qt5.sh
EOF

as_root install -m755 ./qt5.sh /etc/profile.d/qt5.sh &&

cat > ./qt << "EOF" &&
Defaults env_keep += QT5DIR
EOF

as_root install -m644 ./qt /etc/sudoers.d/qt &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
