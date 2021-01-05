#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gtksourceview-3.24.11
 then
  rm -rf /sources/gtksourceview-3.24.11
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/gtksourceview/3.24/gtksourceview-3.24.11.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-gtksourceview &&

tar xf /sources/gtksourceview-3.24.11.tar.xz -C /sources/ &&

cd /sources/gtksourceview-3.24.11 &&

./configure --prefix=/usr --enable-gtk-doc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
