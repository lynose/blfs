#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libjpeg-turbo-2.0.6
 then
  rm -rf /sources/libjpeg-turbo-2.0.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/libjpeg-turbo-2.0.6.tar.gz ];  
 then
  check_and_download https://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-2.0.6.tar.gz \
    /sources
fi

md5sum -c ${SCRIPTPATH}/md5-libjpeg-turbo  &&

tar xf /sources/libjpeg-turbo-2.0.6.tar.gz -C /sources/ &&

cd /sources/libjpeg-turbo-2.0.6 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=RELEASE  \
      -DENABLE_STATIC=FALSE       \
      -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/libjpeg-turbo-2.0.6 \
      -DCMAKE_INSTALL_DEFAULT_LIBDIR=lib  \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi
as_root rm -f /usr/lib/libjpeg.so* &&^
as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
