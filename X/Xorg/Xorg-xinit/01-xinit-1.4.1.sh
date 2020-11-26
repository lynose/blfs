#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xinit-1.4.1
 then
  rm -rf /sources/xinit-1.4.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.x.org/pub/individual/app/xinit-1.4.1.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xinit &&

tar xf /sources/xinit-1.4.1.tar.bz2 -C /sources/ &&

cd /sources/xinit-1.4.1 &&

./configure $XORG_CONFIG --with-xinitdir=/etc/X11/app-defaults &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root ldconfig &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
