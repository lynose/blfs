#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/icu
 then
  rm -rf /sources/icu
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://github.com/unicode-org/icu/releases/download/release-67-1/icu4c-67_1-src.tgz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-icu &&

tar xf /sources/icu4c-67_1-src.tgz -C /sources/ &&

cd /sources/icu &&

cd source                                    &&

./configure --prefix=/usr                    &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
