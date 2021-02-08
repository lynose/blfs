#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/clucene-core-2.3.3.4
 then
  rm -rf /sources/clucene-core-2.3.3.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/clucene/clucene-core-2.3.3.4.tar.gz \
        /sources &&

check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/clucene-2.3.3.4-contribs_lib-1.patch \
        /sources &&
        
md5sum -c ${SCRIPTPATH}/md5-clucene &&

tar xf /sources/clucene-core-2.3.3.4.tar.gz -C /sources/ &&

cd /sources/clucene-core-2.3.3.4 &&

patch -Np1 -i ../clucene-2.3.3.4-contribs_lib-1.patch &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DBUILD_CONTRIBS_LIB=ON .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
