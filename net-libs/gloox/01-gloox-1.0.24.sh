#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gloox-1.0.24
 then
  as_root rm -rf /sources/gloox-1.0.24
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://camaya.net/download/gloox-1.0.24.tar.bz2 \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-gloox && #Not offical available

tar xf /sources/gloox-1.0.24.tar.bz2 -C /sources/ &&

cd /sources/gloox-1.0.24 &&

./configure --prefix=/usr --disable-static &&
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
