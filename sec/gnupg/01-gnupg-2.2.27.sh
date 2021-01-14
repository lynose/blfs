#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gnupg-2.2.27
 then
  rm -rf /sources/gnupg-2.2.27
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.27.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gnupg &&

tar xf /sources/gnupg-2.2.27.tar.bz2 -C /sources/ &&

cd /sources/gnupg-2.2.27 &&

sed -e '/noinst_SCRIPTS = gpg-zip/c sbin_SCRIPTS += gpg-zip' \
    -i tools/Makefile.in &&

./configure --prefix=/usr            \
            --enable-all-tests     \
            --localstatedir=/var     \
            --enable-g13            \
            --docdir=/usr/share/doc/gnupg-2.2.27 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&

makeinfo --html --no-split -o doc/gnupg_nochunks.html doc/gnupg.texi &&
makeinfo --plaintext       -o doc/gnupg.txt           doc/gnupg.texi &&
make -C doc html &&
make -C doc pdf &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&

as_root install -v -m755 -d /usr/share/doc/gnupg-2.2.27/html            &&
as_root install -v -m644    doc/gnupg_nochunks.html \
                    /usr/share/doc/gnupg-2.2.27/html/gnupg.html &&
as_root install -v -m644    doc/*.texi doc/gnupg.txt \
                    /usr/share/doc/gnupg-2.2.27 &&
as_root install -v -m644    doc/gnupg.html/* \
                    /usr/share/doc/gnupg-2.2.27/html &&
as_root install -v -m644 doc/gnupg.{pdf,dvi,ps} \
                 /usr/share/doc/gnupg-2.2.27 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
