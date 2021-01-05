#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/qca-2.3.1
 then
  rm -rf /sources/qca-2.3.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.kde.org/stable/qca/2.3.1/qca-2.3.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-qca &&

tar xf /sources/qca-2.3.1.tar.xz -C /sources/ &&

cd /sources/qca-2.3.1 &&

sed -i 's@cert.pem@certs/ca-bundle.crt@' CMakeLists.txt &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=$QT5DIR            \
      -DCMAKE_BUILD_TYPE=Release                \
      -DQCA_MAN_INSTALL_DIR:PATH=/usr/share/man \
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
