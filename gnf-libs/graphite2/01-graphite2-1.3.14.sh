#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/graphite2-1.3.14
 then
  rm -rf /sources/graphite2-1.3.14
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/silnrsi/graphite/releases/download/1.3.14/graphite2-1.3.14.tgz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-graphite2 &&

tar xf /sources/graphite2-1.3.14.tgz -C /sources/ &&

cd /sources/graphite2-1.3.14 &&

sed -i '/cmptest/d' tests/CMakeLists.txt &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make test &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
install -v -d -m755 /usr/share/doc/graphite2-1.3.14 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
