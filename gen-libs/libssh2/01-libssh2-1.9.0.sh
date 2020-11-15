#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libssh2-1.9.0
 then
  rm -rf /sources/libssh2-1.9.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.libssh2.org/download/libssh2-1.9.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libssh2 &&

tar xf /sources/libssh2-1.9.0.tar.gz -C /sources/ &&

cd /sources/libssh2-1.9.0 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
