#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&
SCRIPT=`realpath $0` 
SCRIPTPATH=`dirname $SCRIPT`

${log} `basename "$0"` " download" blfs_all &&

if test -d /sources/libarchive-3.4.3
 then
  rm -rf /sources/libarchive-3.4.3
fi

check_and_download https://github.com/libarchive/libarchive/releases/download/v3.4.3/libarchive-3.4.3.tar.xz \
    /sources &&

check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/libarchive-3.4.3-testsuite_fix-1.patch \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-libarchive &&



tar xf /sources/libarchive-3.4.3.tar.xz -C /sources/ &&

cd /sources/libarchive-3.4.3 &&

patch -Np1 -i ../libarchive-3.4.3-testsuite_fix-1.patch &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  LC_ALL=C make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi



as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
