#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libgcrypt-1.8.6
 then
  rm -rf /sources/libgcrypt-1.8.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.8.6.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libgcrypt &&

tar xf /sources/libgcrypt-1.8.6.tar.bz2 -C /sources/ &&

cd /sources/libgcrypt-1.8.6 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make                      &&

make -C doc html                                                       &&
makeinfo --html --no-split -o doc/gcrypt_nochunks.html doc/gcrypt.texi &&
makeinfo --plaintext       -o doc/gcrypt.txt           doc/gcrypt.texi &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -v -dm755   /usr/share/doc/libgcrypt-1.8.6 &&
as_root install -v -m644    README doc/{README.apichanges,fips*,libgcrypt*} \
                    /usr/share/doc/libgcrypt-1.8.6 &&

as_root install -v -dm755   /usr/share/doc/libgcrypt-1.8.6/html &&
as_root install -v -m644 doc/gcrypt.html/* \
                    /usr/share/doc/libgcrypt-1.8.6/html &&
as_root install -v -m644 doc/gcrypt_nochunks.html \
                    /usr/share/doc/libgcrypt-1.8.6      &&
as_root install -v -m644 doc/gcrypt.{txt,texi} \
                    /usr/share/doc/libgcrypt-1.8.6 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
