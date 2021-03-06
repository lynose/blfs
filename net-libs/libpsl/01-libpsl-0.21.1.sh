#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libpsl-0.21.1
 then
  rm -rf /sources/libpsl-0.21.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/rockdaboot/libpsl/releases/download/0.21.1/libpsl-0.21.1.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libpsl &&

tar xf /sources/libpsl-0.21.1.tar.gz -C /sources/ &&

cd /sources/libpsl-0.21.1 &&

sed -i 's/env python/&3/' src/psl-make-dafsa &&
./configure --prefix=/usr --disable-static   &&
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
