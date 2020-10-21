#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ModemManager-1.14.0
 then
  rm -rf /sources/ModemManager-1.14.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.freedesktop.org/software/ModemManager/ModemManager-1.14.0.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-ModemManager &&

tar xf /sources/ModemManager-1.14.0.tar.xz -C /sources/ &&

cd /sources/ModemManager-1.14.0 &&

./configure --prefix=/usr                 \
            --sysconfdir=/etc             \
            --localstatedir=/var          \
            --with-systemd-journal        \
            --with-systemd-suspend-resume \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
