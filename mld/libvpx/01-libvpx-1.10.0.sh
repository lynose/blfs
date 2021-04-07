#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libvpx-1.10.0
 then
  rm -rf /sources/libvpx-1.10.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/webmproject/libvpx/archive/v1.10.0/libvpx-1.10.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libvpx &&

tar xf /sources/libvpx-1.10.0.tar.gz -C /sources/ &&

cd /sources/libvpx-1.10.0 &&

sed -i 's/cp -p/cp/' build/make/Makefile &&

mkdir libvpx-build            &&
cd    libvpx-build            &&

../configure --prefix=/usr    \
             --enable-shared  \
             --disable-static  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  LD_LIBRARY_PATH=. make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
