#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libnl-3.5.0
 then
  rm -rf /sources/libnl-3.5.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/thom311/libnl/releases/download/libnl3_5_0/libnl-3.5.0.tar.gz \
    /sources &&
    
check_and_download https://github.com/thom311/libnl/releases/download/libnl3_5_0/libnl-doc-3.5.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libnl &&

tar xf /sources/libnl-3.5.0.tar.gz -C /sources/ &&

cd /sources/libnl-3.5.0 &&

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static &&
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
as_root mkdir -vp /usr/share/doc/libnl-3.5.0 &&
as_root tar -xf ../libnl-doc-3.5.0.tar.gz --strip-components=1 --no-same-owner \
    -C  /usr/share/doc/libnl-3.5.0 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
