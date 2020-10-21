#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gnutls-3.6.14
 then
  rm -rf /sources/gnutls-3.6.14
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.14.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-gnutls &&

tar xf /sources/gnutls-3.6.14.tar.xz -C /sources/ &&

cd /sources/gnutls-3.6.14 &&

./configure --prefix=/usr \
            --docdir=/usr/share/doc/gnutls-3.6.14 \
            --disable-guile \
            --with-default-trust-store-pkcs11="pkcs11:" \
            --enable-gtk-doc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
