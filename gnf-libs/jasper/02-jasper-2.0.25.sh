#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/jasper-version-2.0.25
 then
  as_root rm -rf /sources/jasper-version-2.0.25
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/jasper-software/jasper/archive/version-2.0.25/jasper-2.0.25.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-jasper &&

tar xf /sources/jasper-2.0.25.tar.gz -C /sources/ &&

cd /sources/jasper-version-2.0.25 &&

mkdir BUILD &&
cd    BUILD &&

cmake -DCMAKE_INSTALL_PREFIX=/usr    \
      -DCMAKE_BUILD_TYPE=Release     \
      -DCMAKE_SKIP_INSTALL_RPATH=YES \
      -DJAS_ENABLE_DOC=YES           \
      -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/jasper-2.0.25 \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
