#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/id3lib-3.8.3
 then
  rm -rf /sources/id3lib-3.8.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/id3lib/id3lib-3.8.3.tar.gz \
        /sources
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/id3lib-3.8.3-consolidated_patches-1.patch \
        /sources



md5sum -c ${SCRIPTPATH}/md5-id3lib &&

tar xf /sources/id3lib-3.8.3.tar.gz -C /sources/ &&

cd /sources/id3lib-3.8.3 &&

patch -Np1 -i ../id3lib-3.8.3-consolidated_patches-1.patch &&

libtoolize -fc                &&
aclocal                       &&
autoconf                      &&
automake --add-missing --copy &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root cp doc/man/* /usr/share/man/man1 &&

as_root install -v -m755 -d /usr/share/doc/id3lib-3.8.3 &&
as_root install -v -m644 doc/*.{gif,jpg,png,ico,css,txt,php,html} \
                    /usr/share/doc/id3lib-3.8.3 &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
