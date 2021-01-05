#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/sane-backends-1.0.29
 then
  rm -rf /sources/sane-backends-1.0.29
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://anduin.linuxfromscratch.org/BLFS/sane/sane-backends-1.0.29.tar.gz \
        /sources
check_and_download http://anduin.linuxfromscratch.org/BLFS/sane/sane-frontends-1.0.14.tar.gz \
        /sources

md5sum -c ${SCRIPTPATH}/md5-sane &&

tar xf /sources/sane-backends-1.0.29.tar.gz -C /sources/ &&

cd /sources/sane-backends-1.0.29 &&

as_root_groupadd groupadd -g 70 scanner &&


sudo sg scanner -c "                  \
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --enable-libusb_1_0  \
            --with-group=scanner \
            --with-docdir=/usr/share/doc/sane-backends-1.0.29" &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -m 644 -v tools/udev/libsane.rules           \
                  /etc/udev/rules.d/65-scanner.rules &&
as_root chgrp -v scanner  /var/lock/sane &&

${log} `basename "$0"` " installed" blfs_all &&

tar -xf ../sane-frontends-1.0.14.tar.gz &&
cd sane-frontends-1.0.14                &&

sed -i -e "/SANE_CAP_ALWAYS_SETTABLE/d" src/gtkglue.c &&
./configure --prefix=/usr --mandir=/usr/share/man &&
${log} `basename "$0"` " configured SANE frontends" blfs_all &&
make &&
${log} `basename "$0"` " SANE frontends built" blfs_all &&

as_root make install &&
as_root install -v -m644 doc/sane.png xscanimage-icon-48x48-2.png \
    /usr/share/sane &&
as_root ln -v -s ../../../../bin/xscanimage /usr/lib/gimp/2.0/plug-ins &&

as_root mkdir -pv /usr/share/{applications,pixmaps}               &&

cat > ./xscanimage.desktop << "EOF" &&
[Desktop Entry]
Encoding=UTF-8
Name=XScanImage - Scanning
Comment=Acquire images from a scanner
Exec=xscanimage
Icon=xscanimage
Terminal=false
Type=Application
Categories=Application;Graphics
EOF

as_root mv xscanimage.desktop /usr/share/applications/xscanimage.desktop &&

as_root ln -svf ../sane/xscanimage-icon-48x48-2.png /usr/share/pixmaps/xscanimage.png &&

${log} `basename "$0"` " SANE frontends installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
