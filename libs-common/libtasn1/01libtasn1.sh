#!/bin/bash

${log} `basename "$0"` " started" libs-common &&

if test -d /sources/libtasn1-4.16.0
 then
  rm -rf /sources/libtasn1-4.16.0
fi
tar -xzf /sources/libtasn1-4.16.0.tar.gz -C /sources/ &&

cd /sources/libtasn1-4.16.0 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" libs-common &&

make && 
${log} `basename "$0"` " build" libs-common &&

make check &&          #Ignoring result, not related to multithread
${log} `basename "$0"` " Unexpected Test succeeded" libs-common
${log} `basename "$0"` " expected test fail?" libs-common

make install &&
${log} `basename "$0"` " installed" libs-common &&

make -C doc/reference install-data-local &&
${log} `basename "$0"` " docs" libs-common &&

${log} `basename "$0"` " finished" libs-common
