#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/zip30
 then
  rm -rf /sources/zip30
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/zip30.tar.gz ];  
 then
  check_and_download https://downloads.sourceforge.net/infozip/zip30.tar.gz \
    /sources
fi

md5sum -c ${SCRIPTPATH}/md5-zip &&

tar xf /sources/zip30.tar.gz -C /sources/ &&

cd /sources/zip30 &&

make -f unix/Makefile generic_gcc &&
${log} `basename "$0"` " built" blfs_all &&

as_root make prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
