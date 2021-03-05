#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libiodbc-3.52.14
 then
  as_root rm -rf /sources/libiodbc-3.52.14
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/iodbc/libiodbc-3.52.14.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-libiodbc &&

tar xf /sources/libiodbc-3.52.14.tar.gz -C /sources/ &&

cd /sources/libiodbc-3.52.14 &&

./configure --prefix=/usr                   \
            --with-iodbc-inidir=/etc/iodbc  \
            --includedir=/usr/include/iodbc \
            --disable-libodbc               \
            --disable-static  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
