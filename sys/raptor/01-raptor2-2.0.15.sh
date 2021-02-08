#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/raptor2-2.0.15
 then
  rm -rf /sources/raptor2-2.0.15
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.librdf.org/source/raptor2-2.0.15.tar.gz \
        /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/raptor-2.0.15-security_fixes-1.patch \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-raptor &&

tar xf /sources/raptor2-2.0.15.tar.gz -C /sources/ &&

cd /sources/raptor2-2.0.15 &&

patch -Np1 -i ../raptor-2.0.15-security_fixes-1.patch &&

./configure --prefix=/usr \
            --disable-static \
            --with-icu-config=/usr/bin/icu-config &&
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
