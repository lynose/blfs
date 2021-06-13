#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pango-1.48.5
 then
  as_root rm -rf /sources/pango-1.48.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/pango/1.48/pango-1.48.5.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-pango &&

tar xf /sources/pango-1.48.5.tar.xz -C /sources/ &&

cd /sources/pango-1.48.5 &&

mkdir build &&
cd    build &&

meson --prefix=/usr --buildtype=release -Dgtk_doc=true .. &&
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
