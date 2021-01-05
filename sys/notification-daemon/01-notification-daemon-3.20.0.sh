#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/notification-daemon-3.20.0
 then
  rm -rf /sources/notification-daemon-3.20.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/notification-daemon/3.20/notification-daemon-3.20.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-notification-daemon &&

tar xf /sources/notification-daemon-3.20.0.tar.xz -C /sources/ &&

cd /sources/notification-daemon-3.20.0 &&

./configure --prefix=/usr     \
            --sysconfdir=/etc \
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
