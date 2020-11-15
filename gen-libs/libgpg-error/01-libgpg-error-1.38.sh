#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libgpg-error-1.38
 then
  rm -rf /sources/libgpg-error-1.38
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.38.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libgpg-error &&

tar xf /sources/libgpg-error-1.38.tar.bz2 -C /sources/ &&

cd /sources/libgpg-error-1.38 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
as_root install -v -m644 -D README /usr/share/doc/libgpg-error-1.38/README &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
