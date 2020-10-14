#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libXdmcp-1.1.3
 then
  rm -rf /sources/libXdmcp-1.1.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.x.org/pub/individual/lib/libXdmcp-1.1.3.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-libXdmcp &&

tar xf /sources/libXdmcp-1.1.3.tar.bz2 -C /sources/ &&

cd /sources/libXdmcp-1.1.3 &&

./configure $XORG_CONFIG --docdir=/usr/share/doc/libXdmcp-1.1.3  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
