#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libmusicbrainz-5.1.0
 then
  rm -rf /sources/libmusicbrainz-5.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/metabrainz/libmusicbrainz/releases/download/release-5.1.0/libmusicbrainz-5.1.0.tar.gz \
    /sources &&
    
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/libmusicbrainz-5.1.0-cmake_fixes-1.patch \
    /sources &&    

md5sum -c ${SCRIPTPATH}/md5-libmusicbrainz &&

tar xf /sources/libmusicbrainz-5.1.0.tar.gz -C /sources/ &&

cd /sources/libmusicbrainz-5.1.0 &&

patch -Np1 -i ../libmusicbrainz-5.1.0-cmake_fixes-1.patch &&
 

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
doxygen ../Doxyfile &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root rm -rf /usr/share/doc/libmusicbrainz-5.1.0 &&
as_root cp -vr docs/ /usr/share/doc/libmusicbrainz-5.1.0 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
