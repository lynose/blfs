#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/falkon-3.1.0
 then
  as_root rm -rf /sources/falkon-3.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.kde.org/stable/falkon/3.1/falkon-3.1.0.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-falkon &&

tar xf /sources/falkon-3.1.0.tar.xz -C /sources/ &&

cd /sources/falkon-3.1.0 &&


rm -rf po/ &&
sed -i '/#include <QSettings>/a#include <QFile>' \
   src/plugins/VerticalTabs/verticaltabsplugin.cpp &&
sed -i '/#include <QPainter>/a #include <QPainterPath>' \
   src/lib/tools/qztools.cpp &&
mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
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
