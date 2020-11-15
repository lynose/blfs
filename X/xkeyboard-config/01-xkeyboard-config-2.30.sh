#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xkeyboard-config-2.30
 then
  rm -rf /sources/xkeyboard-config-2.30
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.30.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xkeyboard-config &&

tar xf /sources/xkeyboard-config-2.30.tar.bz2 -C /sources/ &&

cd /sources/xkeyboard-config-2.30 &&

./configure $XORG_CONFIG --with-xkb-rules-symlink=xorg &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
