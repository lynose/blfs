#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/glib-networking-2.64.3
 then
  rm -rf /sources/glib-networking-2.64.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/glib-networking/2.64/glib-networking-2.64.3.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-glib-networking &&

tar xf /sources/glib-networking-2.64.3.tar.xz -C /sources/ &&

cd /sources/glib-networking-2.64.3 &&

mkdir build &&
cd    build &&

meson --prefix=/usr          \
      -Dlibproxy=disabled .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
