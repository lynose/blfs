#!/bin/bash

${log} `basename "$0"` " started" blfs_basic &&

if test -d /sources/libtasn1-4.16.0
 then
  rm -rf /sources/libtasn1-4.16.0
fi

tar -xzf /sources/libtasn1-4.16.0.tar.gz -C /sources/ &&

cd /sources/libtasn1-4.16.0 &&

./configure --prefix=/usr --disable-static &&
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

make -C doc/reference install-data-local &&
${log} `basename "$0"` " docs" blfs_basic &&

${log} `basename "$0"` " finished" blfs_basic
