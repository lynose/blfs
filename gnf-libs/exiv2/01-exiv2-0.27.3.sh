#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/exiv2-0.27.3-Source
 then
  rm -rf /sources/exiv2-0.27.3-Source
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.exiv2.org/builds/exiv2-0.27.3-Source.tar.gz \
    /sources &&
check_and_download https://www.linuxfromscratch.org/patches/blfs/svn/exiv2-0.27.3-security_fixes-1.patch \
    /sources &&
md5sum -c ${SCRIPTPATH}/md5-exiv2 &&

tar xf /sources/exiv2-0.27.3-Source.tar.gz -C /sources/ &&

cd /sources/exiv2-0.27.3-Source &&

patch -Np1 -i ../exiv2-0.27.3-security_fixes-1.patch &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr  \
      -DCMAKE_BUILD_TYPE=Release   \
      -DEXIV2_ENABLE_VIDEO=yes     \
      -DEXIV2_ENABLE_WEBREADY=yes  \
      -DEXIV2_ENABLE_CURL=yes      \
      -DEXIV2_BUILD_SAMPLES=no     \
      -G "Unix Makefiles" ..  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
