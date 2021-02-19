#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libxklavier-5.4
 then
  as_root rm -rf /sources/libxklavier-5.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://people.freedesktop.org/~svu/libxklavier-5.4.tar.bz2 \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-libxklavier &&

tar xf /sources/libxklavier-5.4.tar.bz2 -C /sources/ &&

cd /sources/libxklavier-5.4 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
