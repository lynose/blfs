#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if test -d /sources/doxygen-1.9.1
 then
  rm -rf /sources/doxygen-1.9.1
fi

${log} `basename "$0"` " Downloading" blfs_all &&
check_and_download http://doxygen.nl/files/doxygen-1.9.1.src.tar.gz \
/sources &&

md5sum -c ${SCRIPTPATH}/md5-doxygen &&

tar xf /sources/doxygen-1.9.1.src.tar.gz -C /sources/ &&

cd /sources/doxygen-1.9.1 &&

rm src/._xmlgen.cpp &&

mkdir -v build &&
cd       build &&

cmake -G "Unix Makefiles"         \
      -DCMAKE_BUILD_TYPE=Release  \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -Wno-dev .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " build" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make tests &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -vm644 ../doc/*.1 /usr/share/man/man1 &&
${log} `basename "$0"` " installed" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
