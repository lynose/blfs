#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pinentry-1.1.1
 then
  rm -rf /sources/pinentry-1.1.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-1.1.1.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-pinentry &&

tar xf /sources/pinentry-1.1.1.tar.bz2 -C /sources/ &&

cd /sources/pinentry-1.1.1 &&

./configure --prefix=/usr --enable-pinentry-tty &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
