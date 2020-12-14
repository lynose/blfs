#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/telepathy-glib-0.24.1
 then
  rm -rf /sources/telepathy-glib-0.24.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://telepathy.freedesktop.org/releases/telepathy-glib/telepathy-glib-0.24.1.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-telepathy-glib &&

tar xf /sources/telepathy-glib-0.24.1.tar.gz -C /sources/ &&

cd /sources/telepathy-glib-0.24.1 &&

./configure --prefix=/usr          \
            --enable-vala-bindings \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make -k check &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
