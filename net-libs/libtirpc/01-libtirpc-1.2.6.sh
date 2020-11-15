#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libtirpc-1.2.6
 then
  rm -rf /sources/libtirpc-1.2.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/libtirpc-1.2.6.tar.bz2 ];  
 then
  check_and_download https://downloads.sourceforge.net/libtirpc/libtirpc-1.2.6.tar.bz2 \
    /sources
fi

md5sum -c ${SCRIPTPATH}/md5-libtirpc &&

tar xf /sources/libtirpc-1.2.6.tar.bz2 -C /sources/ &&

cd /sources/libtirpc-1.2.6 &&

./configure --prefix=/usr                                   \
            --sysconfdir=/etc                               \
            --disable-static                                \
            --disable-gssapi  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root as_root mv -v /usr/lib/libtirpc.so.* /lib &&
as_root ln -sfv ../../lib/libtirpc.so.3.0.0 /usr/lib/libtirpc.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
