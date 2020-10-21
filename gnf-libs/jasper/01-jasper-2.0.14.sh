#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/jasper-2.0.14
 then
  rm -rf /sources/jasper-2.0.14
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://www.ece.uvic.ca/~frodo/jasper/software/jasper-2.0.14.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-jasper &&

tar xf /sources/jasper-2.0.14.tar.gz -C /sources/ &&

cd /sources/jasper-2.0.14 &&

mkdir BUILD &&
cd    BUILD &&

cmake -DCMAKE_INSTALL_PREFIX=/usr    \
      -DCMAKE_BUILD_TYPE=Release     \
      -DCMAKE_SKIP_INSTALL_RPATH=YES \
      -DJAS_ENABLE_DOC=NO            \
      -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/jasper-2.0.14 \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make test &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
