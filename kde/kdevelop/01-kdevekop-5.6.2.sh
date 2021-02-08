#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/kdevelop-5.6.2
 then
  rm -rf /sources/kdevelop-5.6.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.kde.org/stable/kdevelop/5.6.2/src/kdevelop-5.6.2.tar.xz \
        /sources &&

gpg --verify ${SCRIPTPATH}/kdevelop-5.6.2.tar.xz.sig /sources/kdevelop-5.6.2.tar.xz

tar xf /sources/kdevelop-5.6.2.tar.xz -C /sources/ &&

cd /sources/kdevelop-5.6.2 &&

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
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
