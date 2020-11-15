#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/npth-1.6
 then
  rm -rf /sources/npth-1.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.gnupg.org/ftp/gcrypt/npth/npth-1.6.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-npth &&

tar xf /sources/npth-1.6.tar.bz2 -C /sources/ &&

cd /sources/npth-1.6 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
