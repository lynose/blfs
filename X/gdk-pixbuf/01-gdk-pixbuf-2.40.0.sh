#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gdk-pixbuf-2.40.0
 then
  rm -rf /sources/gdk-pixbuf-2.40.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.40/gdk-pixbuf-2.40.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gdk-pixbuf &&

tar xf /sources/gdk-pixbuf-2.40.0.tar.xz -C /sources/ &&

cd /sources/gdk-pixbuf-2.40.0 &&

mkdir build &&
cd build &&

meson --prefix=/usr .. &&
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
gdk-pixbuf-query-loaders --update-cache &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
