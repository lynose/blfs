#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cpio-2.13
 then
  rm -rf /sources/cpio-2.13
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/cpio/cpio-2.13.tar.bz2 \
        /sources


md5sum -c ${SCRIPTPATH}/md5-cpio &&

tar xf /sources/cpio-2.13.tar.bz2 -C /sources/ &&

cd /sources/cpio-2.13 &&

sed -i '/The name/,+2 d' src/global.c &&


./configure --prefix=/usr \
            --bindir=/bin \
            --enable-mt   \
            --with-rmt=/usr/libexec/rmt &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
makeinfo --html            -o doc/html      doc/cpio.texi &&
makeinfo --html --no-split -o doc/cpio.html doc/cpio.texi &&
makeinfo --plaintext       -o doc/cpio.txt  doc/cpio.texi &&
make -C doc pdf &&
make -C doc ps &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -v -m755 -d /usr/share/doc/cpio-2.13/html &&
as_root install -v -m644    doc/html/* \
                    /usr/share/doc/cpio-2.13/html &&
as_root install -v -m644    doc/cpio.{html,txt} \
                    /usr/share/doc/cpio-2.13 &&
as_root install -v -m644 doc/cpio.{pdf,ps,dvi} \
                 /usr/share/doc/cpio-2.13 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
