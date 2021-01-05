#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/nettle-3.6
 then
  rm -rf /sources/nettle-3.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/nettle/nettle-3.6.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-nettle &&

tar xf /sources/nettle-3.6.tar.gz -C /sources/ &&

cd /sources/nettle-3.6 &&

./configure --prefix=/usr --disable-static &&
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
as_root chmod   -v   755 /usr/lib/lib{hogweed,nettle}.so &&
as_root install -v -m755 -d /usr/share/doc/nettle-3.6 &&
as_root install -v -m644 nettle.html /usr/share/doc/nettle-3.6 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
