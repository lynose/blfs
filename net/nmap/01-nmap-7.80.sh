#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/nmap-7.80
 then
  rm -rf /sources/nmap-7.80
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://nmap.org/dist/nmap-7.80.tar.bz2 \
        /sources


md5sum -c ${SCRIPTPATH}/md5-nmap &&

tar xf /sources/nmap-7.80.tar.bz2 -C /sources/ &&

cd /sources/nmap-7.80 &&

./configure --prefix=/usr --with-liblua=included &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  sed -i 's/lib./lib/' zenmap/test/run_tests.py &&
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
