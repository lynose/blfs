#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lcms2-2.12
 then
  rm -rf /sources/lcms2-2.12
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/lcms2-2.12.tar.gz ];  
 then
  check_and_download https://downloads.sourceforge.net/lcms/lcms2-2.12.tar.gz \
    /sources
fi

md5sum -c ${SCRIPTPATH}/md5-lcms2 &&

tar xf /sources/lcms2-2.12.tar.gz -C /sources/ &&

cd /sources/lcms2-2.12 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
