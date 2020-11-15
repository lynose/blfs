#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xclock-1.0.9
 then
  rm -rf /sources/xclock-1.0.9
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.x.org/pub/individual/app/xclock-1.0.9.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xclock &&

tar xf /sources/xclock-1.0.9.tar.bz2 -C /sources/ &&

cd /sources/xclock-1.0.9 &&

./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
