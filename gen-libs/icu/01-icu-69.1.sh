#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/icu
 then
  rm -rf /sources/icu
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://github.com/unicode-org/icu/releases/download/release-69-1/icu4c-69_1-src.tgz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-icu &&

tar xf /sources/icu4c-69_1-src.tgz -C /sources/ &&

cd /sources/icu &&

cd source                                 &&

./configure --prefix=/usr                    &&
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
