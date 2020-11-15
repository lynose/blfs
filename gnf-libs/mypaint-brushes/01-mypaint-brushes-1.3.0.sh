#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mypaint-brushes-v1.3.0
 then
  rm -rf /sources/mypaint-brushes-v1.3.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/Jehan/mypaint-brushes/archive/v1.3.0/mypaint-brushes-v1.3.0.tar.gz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/mypaint-brushes-1.3.0-automake_1.16-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-mypaint-brushes &&

tar xf /sources/mypaint-brushes-v1.3.0.tar.gz -C /sources/ &&

cd /sources/mypaint-brushes-1.3.0 &&

patch -Np1 -i ../mypaint-brushes-1.3.0-automake_1.16-1.patch &&
./autogen.sh                                                 &&
./configure --prefix=/usr  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
