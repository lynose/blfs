#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/elfutils-0.183
 then
  as_root rm -rf /sources/elfutils-0.183
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://sourceware.org/ftp/elfutils/0.183/elfutils-0.183.tar.bz2 \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-elfutils &&

tar xf /sources/elfutils-0.183.tar.bz2 -C /sources/ &&

cd /sources/elfutils-0.183 &&

./configure --prefix=/usr                \
            --disable-debuginfod         \
            --enable-libdebuginfod=dummy \
            --libdir=/usr/lib &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make -C libdw install &&
as_root make -C libdwfl install &&
as_root install -vm644 config/libdw.pc /usr/lib/pkgconfig &&
as_root rm /usr/lib/libdw.a &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
