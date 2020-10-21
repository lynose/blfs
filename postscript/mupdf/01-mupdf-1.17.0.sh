#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mupdf-1.17.0
 then
  rm -rf /sources/mupdf-1.17.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://www.mupdf.com/downloads/archive/mupdf-1.17.0-source.tar.gz \
    --continue --directory-prefix=/sources &&
wget http://www.linuxfromscratch.org/patches/blfs/10.0/mupdf-1.17.0-shared_libs-1.patch \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-mupdf &&

tar xf /sources/mupdf-1.17.0-source.tar.gz -C /sources/ &&

cd /sources/mupdf-1.17.0-source &&

patch -Np1 -i ../mupdf-1.17.0-shared_libs-1.patch &&
${log} `basename "$0"` " configured" blfs_all &&

USE_SYSTEM_LIBS=yes make &&
${log} `basename "$0"` " built" blfs_all &&

USE_SYSTEM_LIBS=yes                     \
make prefix=/usr                        \
     build=release                      \
     docdir=/usr/share/doc/mupdf-1.17.0 \
     install                            &&

ln -sfv mupdf-x11 /usr/bin/mupdf        &&
ldconfig &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
