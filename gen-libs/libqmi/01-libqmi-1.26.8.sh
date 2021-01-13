#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libqmi-1.26.8
 then
  rm -rf /sources/libqmi-1.26.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/libqmi/libqmi-1.26.8.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libqmi &&

tar xf /sources/libqmi-1.26.8.tar.xz -C /sources/ &&

cd /sources/libqmi-1.26.8 &&

./configure --prefix=/usr --disable-static --enable-gtk-doc &&
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
