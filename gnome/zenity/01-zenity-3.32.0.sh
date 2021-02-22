#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/zenity-3.32.0
 then
  as_root rm -rf /sources/zenity-3.32.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gnome.org/sources/zenity/3.32/zenity-3.32.0.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-zenity &&

tar xf /sources/zenity-3.32.0.tar.xz -C /sources/ &&

cd /sources/zenity-3.32.0 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
