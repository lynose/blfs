#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libgdata-0.17.12
 then
  rm -rf /sources/libgdata-0.17.12
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/libgdata/0.17/libgdata-0.17.12.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libgdata &&

tar xf /sources/libgdata-0.17.12.tar.xz -C /sources/ &&

cd /sources/libgdata-0.17.12 &&



mkdir build &&
cd    build &&

meson --prefix=/usr -Dgtk_doc=false -Dalways_build_tests=false ..  &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
