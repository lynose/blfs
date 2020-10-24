#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/frei0r-plugins-1.7.0
 then
  rm -rf /sources/frei0r-plugins-1.7.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://files.dyne.org/frei0r/releases/frei0r-plugins-1.7.0.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-frei0r-plugins &&

tar xf /sources/frei0r-plugins-1.7.0.tar.gz -C /sources/ &&

cd /sources/frei0r-plugins-1.7.0 &&

mkdir -vp build &&
cd        build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -DWITHOUT_OPENCV=TRUE       \
      -Wno-dev ..        &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
