#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/opus-1.3.1
 then
  rm -rf /sources/opus-1.3.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-opus &&

tar xf /sources/opus-1.3.1.tar.gz -C /sources/ &&

cd /sources/opus-1.3.1 &&

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/opus-1.3.1 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
