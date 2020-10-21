#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/glu-9.0.1
 then
  rm -rf /sources/glu-9.0.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.1.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-glu &&

tar xf /sources/glu-9.0.1.tar.xz -C /sources/ &&

cd /sources/glu-9.0.1 &&

./configure --prefix=$XORG_PREFIX --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
