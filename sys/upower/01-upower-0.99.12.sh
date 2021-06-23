#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/upower-0.99.12
 then
  rm -rf /sources/upower-0.99.12
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://gitlab.freedesktop.org/upower/upower/uploads/244f5966c58773bbd3b4c507c549560f/upower-0.99.12.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-upower &&

tar xf /sources/upower-0.99.12.tar.xz -C /sources/ &&

cd /sources/upower-0.99.12 &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --enable-deprecated  \
            --enable-gtk-doc     \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root systemctl enable upower &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
