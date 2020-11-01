#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/freeglut-3.2.1
 then
  rm -rf /sources/freeglut-3.2.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/freeglut-3.2.1.tar.gz ];
 then
  wget https://downloads.sourceforge.net/freeglut/freeglut-3.2.1.tar.gz \
        --continue --directory-prefix=/sources
fi

if [ ! -f /sources/freeglut-3.2.1-gcc10_fix-1.patch ];
 then
  wget http://www.linuxfromscratch.org/patches/blfs/10.0/freeglut-3.2.1-gcc10_fix-1.patch \
    --continue --directory-prefix=/sources
fi
md5sum -c ${SCRIPTPATH}/md5-freeglut &&

tar xf /sources/freeglut-3.2.1.tar.gz -C /sources/ &&

cd /sources/freeglut-3.2.1 &&

patch -Np1 -i ../freeglut-3.2.1-gcc10_fix-1.patch &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr       \
      -DCMAKE_BUILD_TYPE=Release        \
      -DFREEGLUT_BUILD_DEMOS=OFF        \
      -DFREEGLUT_BUILD_STATIC_LIBS=OFF  \
      -Wno-dev ..  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
