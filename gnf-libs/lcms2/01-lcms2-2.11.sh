#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lcms2-2.11
 then
  rm -rf /sources/lcms2-2.11
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/lcms2-2.11.tar.gz ];  
 then
  wget https://downloads.sourceforge.net/lcms/lcms2-2.11.tar.gz \
    --continue --directory-prefix=/sources
fi

md5sum -c ${SCRIPTPATH}/md5-lcms2 &&

tar xf /sources/lcms2-2.11.tar.gz -C /sources/ &&

cd /sources/lcms2-2.11 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
