#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gpgme-1.14.0
 then
  rm -rf /sources/gpgme-1.14.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.14.0.tar.bz2 \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-gpgme &&

tar xf /sources/gpgme-1.14.0.tar.bz2 -C /sources/ &&

cd /sources/gpgme-1.14.0 &&

./configure --prefix=/usr --disable-gpg-test &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

#make -k check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
