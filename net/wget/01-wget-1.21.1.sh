#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/wget-1.21.1
 then
  rm -rf /sources/wget-1.21.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/wget/wget-1.21.1.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-wget &&

tar xf /sources/wget-1.21.1.tar.gz -C /sources/ &&

cd /sources/wget-1.21.1 &&


./configure --prefix=/usr      \
            --sysconfdir=/etc  \
            --with-ssl=openssl &&
${log} `basename "$0"` " configured" blfs_basic &&

make && 
${log} `basename "$0"` " build" blfs_basic &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_basic &&
${log} `basename "$0"` " finished" blfs_basic
