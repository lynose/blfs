#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gc-8.0.4
 then
  rm -rf /sources/gc-8.0.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.hboehm.info/gc/gc_source/gc-8.0.4.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gc &&

tar xf /sources/gc-8.0.4.tar.gz -C /sources/ &&

cd /sources/gc-8.0.4 &&

./configure --prefix=/usr      \
            --enable-cplusplus \
            --disable-static   \
            --docdir=/usr/share/doc/gc-8.0.4 &&
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
as_root install -v -m644 doc/gc.man /usr/share/man/man3/gc_malloc.3 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
