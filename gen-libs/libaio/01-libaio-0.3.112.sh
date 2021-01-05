#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libaio-0.3.112
 then
  rm -rf /sources/libaio-0.3.112
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.de.debian.org/debian/pool/main/liba/libaio/libaio_0.3.112.orig.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libaio &&

tar xf /sources/libaio_0.3.112.orig.tar.xz -C /sources/ &&

cd /sources/libaio-0.3.112 &&

sed -i '/install.*libaio.a/s/^/#/' src/Makefile &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&


if [ ${ENABLE_TEST} == true ]
 then
  make partcheck &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
