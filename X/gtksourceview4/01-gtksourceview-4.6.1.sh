#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gtksourceview-4.6.1
 then
  rm -rf /sources/gtksourceview-4.6.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/gtksourceview/4.6/gtksourceview-4.6.1.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-gtksourceview4´ &&

tar xf /sources/gtksourceview-4.6.1.tar.xz -C /sources/ &&

cd /sources/gtksourceview-4.6.1 &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Dgtk_doc=true .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi



ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
