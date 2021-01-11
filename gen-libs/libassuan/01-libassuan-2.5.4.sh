#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libassuan-2.5.4
 then
  rm -rf /sources/libassuan-2.5.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.4.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libassuan &&

tar xf /sources/libassuan-2.5.4.tar.bz2 -C /sources/ &&

cd /sources/libassuan-2.5.4 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make -C doc html                                                       &&
makeinfo --html --no-split -o doc/assuan_nochunks.html doc/assuan.texi &&
makeinfo --plaintext       -o doc/assuan.txt           doc/assuan.texi &&
make -C doc pdf ps &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -v -dm755   /usr/share/doc/libassuan-2.5.4/html &&
as_root install -v -m644 doc/assuan.html/* \
                    /usr/share/doc/libassuan-2.5.4/html &&
as_root install -v -m644 doc/assuan_nochunks.html \
                    /usr/share/doc/libassuan-2.5.4      &&
as_root install -v -m644 doc/assuan.{txt,texi} \
                    /usr/share/doc/libassuan-2.5.4 &&
as_root install -v -m644  doc/assuan.{pdf,ps,dvi} \
                  /usr/share/doc/libassuan-2.5.4 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
