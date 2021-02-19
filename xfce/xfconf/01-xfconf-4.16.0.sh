#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xfconf-4.16.0
 then
  as_root rm -rf /sources/xfconf-4.16.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://archive.xfce.org/src/xfce/xfconf/4.16/xfconf-4.16.0.tar.bz2 \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-xfconf &&

tar xf /sources/xfconf-4.16.0.tar.bz2 -C /sources/ &&

cd /sources/xfconf-4.16.0 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
