#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cdparanoia-III-10.2
 then
  rm -rf /sources/cdparanoia-III-10.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.xiph.org/releases/cdparanoia/cdparanoia-III-10.2.src.tgz \
    /sources &&
    
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/cdparanoia-III-10.2-gcc_fixes-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-cdparanoia &&

tar xf /sources/cdparanoia-III-10.2.src.tgz -C /sources/ &&

cd /sources/cdparanoia-III-10.2 &&

patch -Np1 -i ../cdparanoia-III-10.2-gcc_fixes-1.patch &&
./configure --prefix=/usr --mandir=/usr/share/man &&
${log} `basename "$0"` " configured" blfs_all &&

make -j1 &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root chmod -v 755 /usr/lib/libcdda_*.so.0.10.2 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
