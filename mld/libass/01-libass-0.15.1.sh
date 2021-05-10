#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libass-0.15.1
 then
  as_root rm -rf /sources/libass-0.15.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/libass/libass/releases/download/0.15.1/libass-0.15.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libass &&

tar xf /sources/libass-0.15.1.tar.xz -C /sources/ &&

cd /sources/libass-0.15.1 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
