#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libpng-1.6.37
 then
  rm -rf /sources/libpng-1.6.37
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/libpng-1.6.37.tar.xz ];  
 then
  wget https://downloads.sourceforge.net/libpng/libpng-1.6.37.tar.xz \
   --continue --directory-prefix=/sources
fi
if [ ! -f /sources/libpng-1.6.37-apng.patch.gz ];  
 then
  wget https://downloads.sourceforge.net/sourceforge/libpng-apng/libpng-1.6.37-apng.patch.gz \
   --continue --directory-prefix=/sources
fi
md5sum -c ${SCRIPTPATH}/md5-libpng &&

tar xf /sources/libpng-1.6.37.tar.xz -C /sources/ &&

cd /sources/libpng-1.6.37 &&

gzip -cd ../libpng-1.6.37-apng.patch.gz | patch -p1 &&
./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
mkdir -v /usr/share/doc/libpng-1.6.37 &&
cp -v README libpng-manual.txt /usr/share/doc/libpng-1.6.37 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
