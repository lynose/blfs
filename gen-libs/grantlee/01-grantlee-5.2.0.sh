#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/grantlee-5.2.0
 then
  rm -rf /sources/grantlee-5.2.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://downloads.grantlee.org/grantlee-5.2.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-grantlee &&

tar xf /sources/grantlee-5.2.0.tar.gz -C /sources/ &&

cd /sources/grantlee-5.2.0 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      ..  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
