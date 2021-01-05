#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libbytesize-2.4
 then
  rm -rf /sources/libbytesize-2.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/storaged-project/libbytesize/releases/download/2.4/libbytesize-2.4.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libbytesize &&

tar xf /sources/libbytesize-2.4.tar.gz -C /sources/ &&

cd /sources/libbytesize-2.4 &&

./configure --prefix=/usr &&
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
