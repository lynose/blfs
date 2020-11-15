#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libsoup-2.70.0
 then
  rm -rf /sources/libsoup-2.70.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/libsoup/2.70/libsoup-2.70.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libsoup &&

tar xf /sources/libsoup-2.70.0.tar.xz -C /sources/ &&

cd /sources/libsoup-2.70.0 &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Dvapi=enabled -Dgssapi=disabled .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
