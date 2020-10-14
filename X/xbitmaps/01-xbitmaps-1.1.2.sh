#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xbitmaps-1.1.2
 then
  rm -rf /sources/xbitmaps-1.1.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.x.org/pub/individual/data/xbitmaps-1.1.2.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-xbitmaps &&

tar xf /sources/xbitmaps-1.1.2.tar.bz2 -C /sources/ &&

cd /sources/xbitmaps-1.1.2 &&



./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
