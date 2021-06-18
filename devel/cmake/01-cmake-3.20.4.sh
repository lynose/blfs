#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if test -d /sources/cmake-3.20.4
 then
  as_root rm -rf /sources/cmake-3.20.4
fi

${log} `basename "$0"` " Downloading" blfs_all &&
check_and_download https://cmake.org/files/v3.20/cmake-3.20.4.tar.gz \
/sources &&

md5sum -c ${SCRIPTPATH}/md5-cmake &&

tar xf /sources/cmake-3.20.4.tar.gz -C /sources/ &&

cd /sources/cmake-3.20.4 &&



sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake &&

./bootstrap --prefix=/usr        \
            --system-libs        \
            --mandir=/share/man  \
            --no-system-jsoncpp  \
            --no-system-librhash \
            --parallel=${NINJAJOBS} \
            --docdir=/share/doc/cmake-3.20.4  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " build" blfs_all &&

 
if [ ${ENABLE_TEST} == true ]
 then
  LC_ALL=en_US.UTF-8 bin/ctest -j${NINJAJOBS} -O /log/cmake-3.20.4-test.log &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi


as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
