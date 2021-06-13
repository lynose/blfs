#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/v4l-utils-1.20.0
 then
  rm -rf /sources/v4l-utils-1.20.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.linuxtv.org/downloads/v4l-utils/v4l-utils-1.20.0.tar.bz2 \
    /sources &&

check_and_download https://www.linuxfromscratch.org/patches/blfs/svn/v4l-utils-1.20.0-upstream_fixes-1.patch \
    /sources &&
md5sum -c ${SCRIPTPATH}/md5-v4l-utils &&

tar xf /sources/v4l-utils-1.20.0.tar.bz2 -C /sources/ &&

cd /sources/v4l-utils-1.20.0 &&

patch -Np1 -i ../v4l-utils-1.20.0-upstream_fixes-1.patch &&

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
