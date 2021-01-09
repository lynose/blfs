#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pango-1.48.0
 then
  rm -rf /sources/pango-1.48.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/pango/1.46/pango-1.48.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-pango &&

tar xf /sources/pango-1.48.0.tar.xz -C /sources/ &&

cd /sources/pango-1.48.0 &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Dgtk_doc .. &&
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
