#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libtirpc-1.3.2
 then
  rm -rf /sources/libtirpc-1.3.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
check_and_download https://downloads.sourceforge.net/libtirpc/libtirpc-1.3.2.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libtirpc &&

tar xf /sources/libtirpc-1.3.2.tar.bz2 -C /sources/ &&

cd /sources/libtirpc-1.3.2 &&

./configure --prefix=/usr                                   \
            --sysconfdir=/etc                               \
            --disable-static                                &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
