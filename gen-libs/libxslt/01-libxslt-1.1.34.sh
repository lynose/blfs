#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libxslt-1.1.34
 then
  rm -rf /sources/libxslt-1.1.34
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://xmlsoft.org/sources/libxslt-1.1.34.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libxslt &&

tar xf /sources/libxslt-1.1.34.tar.gz -C /sources/ &&

cd /sources/libxslt-1.1.34 &&

sed -i s/3000/5000/ libxslt/transform.c doc/xsltproc.{1,xml} &&
./configure --prefix=/usr --disable-static --without-python &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
sed -e 's@http://cdn.docbook.org/release/xsl@https://cdn.docbook.org/release/xsl-nons@' \
    -e 's@\$Date\$@31 October 2019@' -i doc/xsltproc.xml &&
xsltproc/xsltproc --nonet doc/xsltproc.xml -o doc/xsltproc.1 &&
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
