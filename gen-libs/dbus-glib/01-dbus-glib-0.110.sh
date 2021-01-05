#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/dbus-glib-0.110
 then
  rm -rf /sources/dbus-glib-0.110
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.110.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-dbus-glib &&

tar xf /sources/dbus-glib-0.110.tar.gz -C /sources/ &&

cd /sources/dbus-glib-0.110 &&

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
