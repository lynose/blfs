#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ModemManager-1.16.2
 then
  as_root rm -rf /sources/ModemManager-1.16.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/ModemManager/ModemManager-1.16.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-ModemManager &&

tar xf /sources/ModemManager-1.16.2.tar.xz -C /sources/ &&

cd /sources/ModemManager-1.16.2 &&

./configure --prefix=/usr                 \
            --sysconfdir=/etc             \
            --localstatedir=/var          \
            --with-systemd-journal        \
            --with-systemd-suspend-resume \
            --enable-gtk-doc              \
            --disable-static &&
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
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
