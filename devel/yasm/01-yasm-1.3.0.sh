#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/yasm-1.3.0
 then
  rm -rf /sources/yasm-1.3.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-yasm &&

tar xf /sources/yasm-1.3.0.tar.gz -C /sources/ &&

cd /sources/yasm-1.3.0 &&

sed -i 's#) ytasm.*#)#' Makefile.in &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
