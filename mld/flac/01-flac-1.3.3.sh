#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/flac-1.3.3
 then
  as_root rm -rf /sources/flac-1.3.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.xiph.org/releases/flac/flac-1.3.3.tar.xz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/flac-1.3.3-security_fixes-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-flac &&

tar xf /sources/flac-1.3.3.tar.xz -C /sources/ &&

cd /sources/flac-1.3.3 &&

patch -Np1 -i ../flac-1.3.3-security_fixes-1.patch      &&

./configure --prefix=/usr \
            --disable-thorough-tests \
            --docdir=/usr/share/doc/flac-1.3.3 &&
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
