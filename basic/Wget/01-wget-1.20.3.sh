#!/bin/bash

${log} `basename "$0"` " started" blfs_basic &&

if test -d /sources/wget-1.20.3
 then
  rm -rf /sources/wget-1.20.3
fi

tar -xzf /sources/wget-1.20.3.tar.gz -C /sources/ &&

cd /sources/wget-1.20.3 &&

./configure --prefix=/usr      \
            --sysconfdir=/etc  \
            --with-ssl=openssl &&
${log} `basename "$0"` " configured" blfs_basic &&

make && 
${log} `basename "$0"` " build" blfs_basic &&

make check &&          #Ignoring result, not related to multithread
${log} `basename "$0"` " Unexpected Test succeeded" blfs_basic
${log} `basename "$0"` " expected test fail?" blfs_basic &&

make install &&
${log} `basename "$0"` " installed" blfs_basic &&
${log} `basename "$0"` " finished" blfs_basic
