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
  check_and_download https://downloads.sourceforge.net/libpng/libpng-1.6.37.tar.xz \
   /sources
fi
if [ ! -f /sources/libpng-1.6.37-apng.patch.gz ];  
 then
  check_and_download https://downloads.sourceforge.net/sourceforge/libpng-apng/libpng-1.6.37-apng.patch.gz \
   /sources
fi
md5sum -c ${SCRIPTPATH}/md5-libpng &&

tar xf /sources/libpng-1.6.37.tar.xz -C /sources/ &&

cd /sources/libpng-1.6.37 &&

gzip -cd ../libpng-1.6.37-apng.patch.gz | patch -p1 &&
./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root_mkdir /usr/share/doc/libpng-1.6.37 &&
as_root cp -v README libpng-manual.txt /usr/share/doc/libpng-1.6.37 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
