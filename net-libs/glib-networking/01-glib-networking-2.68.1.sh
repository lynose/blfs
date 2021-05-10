#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/glib-networking-2.68.1
 then
  as_root rm -rf /sources/glib-networking-2.68.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/glib-networking/2.68/glib-networking-2.68.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-glib-networking &&

tar xf /sources/glib-networking-2.68.1.tar.xz -C /sources/ &&

cd /sources/glib-networking-2.68.1 &&

mkdir build &&
cd    build &&

meson --prefix=/usr          \
      -Dlibproxy=disabled .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi


as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
