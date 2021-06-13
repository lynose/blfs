#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libevent-2.1.12-stable
 then
  as_root rm -rf /sources/libevent-2.1.12-stable
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libevent &&

tar xf /sources/libevent-2.1.12-stable.tar.gz -C /sources/ &&

cd /sources/libevent-2.1.12-stable &&

sed -i 's/python/&3/' event_rpcgen.py &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
doxygen Doxyfile &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make verify &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -v -m755 -d /usr/share/doc/libevent-2.1.12/api &&
as_root cp      -v -R       doxygen/html/* \
                    /usr/share/doc/libevent-2.1.12/api
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
