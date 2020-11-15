#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/unzip60
 then
  rm -rf /sources/unzip60
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download ftp://ftp.info-zip.org/pub/infozip/src/unzip60.tgz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/unzip-6.0-consolidated_fixes-1.patch \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-unzip &&

tar xf /sources/unzip60.tgz -C /sources/ &&

cd /sources/unzip60 &&

patch -Np1 -i ../unzip-6.0-consolidated_fixes-1.patch &&

${log} `basename "$0"` " configured" blfs_all &&

make -f unix/Makefile generic &&
${log} `basename "$0"` " built" blfs_all &&

as_root make prefix=/usr MANDIR=/usr/share/man/man1 \
 -f unix/Makefile install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
