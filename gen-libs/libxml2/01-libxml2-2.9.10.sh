#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libxml2-2.9.10
 then
  rm -rf /sources/libxml2-2.9.10
fi

wget http://xmlsoft.org/sources/libxml2-2.9.10.tar.gz \
    --continue --directory-prefix=/sources &&

wget http://www.w3.org/XML/Test/xmlts20130923.tar.gz \
    --continue --directory-prefix=/sources &&
    
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

make check > /log/xml2-check.log &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
