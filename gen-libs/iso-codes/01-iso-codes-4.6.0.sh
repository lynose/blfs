#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/iso-codes-4.6.0
 then
  rm -rf /sources/iso-codes-4.6.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://anduin.linuxfromscratch.org/BLFS/iso-codes/iso-codes-4.6.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-iso-codes &&

tar xf /sources/iso-codes-4.6.0.tar.xz -C /sources/ &&

cd /sources/iso-codes-4.6.0 &&

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

sed -i '/^LN_S/s/s/sfvn/' */Makefile &&
as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
