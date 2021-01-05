#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libxml2-2.9.10
 then
  rm -rf /sources/libxml2-2.9.10
fi

check_and_download http://xmlsoft.org/sources/libxml2-2.9.10.tar.gz \
    /sources &&

check_and_download http://www.w3.org/XML/Test/xmlts20130923.tar.gz \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-libxml2 &&

tar xf /sources/libxml2-2.9.10.tar.gz -C /sources/ &&

cd /sources/libxml2-2.9.10 &&

sed -i 's/test.test/#&/' python/tests/tstLastError.py &&
./configure --prefix=/usr    \
            --disable-static \
            --with-history   \
            --with-python=/usr/bin/python3 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

tar xf ../xmlts20130923.tar.gz &&
${log} `basename "$0"` " install docs" blfs_all &&


if [ ${ENABLE_TEST} == true ]
 then
  make check > /log/xml2-check.log &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
