#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ghostscript-9.52
 then
  rm -rf /sources/ghostscript-9.52
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if [ ! -f /sources/ghostscript-9.52.tar.xz ];  
 then
  check_and_download https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs952/ghostscript-9.52.tar.xz \
    /sources
fi
if [ ! -f /sources/ghostscript-fonts-std-8.11.tar.gz ];  
 then
  check_and_download https://downloads.sourceforge.net/gs-fonts/ghostscript-fonts-std-8.11.tar.gz \
    /sources
fi
if [ ! -f /sources/gnu-gs-fonts-other-6.0.tar.gz ];  
 then
  check_and_download https://downloads.sourceforge.net/gs-fonts/gnu-gs-fonts-other-6.0.tar.gz \
    /sources
fi
    
md5sum -c ${SCRIPTPATH}/md5-ghostscript &&

tar xf /sources/ghostscript-9.52.tar.xz -C /sources/ &&

cd /sources/ghostscript-9.52 &&

rm -rf freetype lcms2mt jpeg libpng openjpeg &&

rm -rf zlib &&

./configure --prefix=/usr           \
            --disable-compile-inits \
            --enable-dynamic        \
            --with-system-libtiff  &&
${log} `basename "$0"` " configured" blfs_all &&

make so &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root make soinstall &&
as_root install -v -m644 base/*.h /usr/include/ghostscript &&
as_root ln -sfvn ghostscript /usr/include/ps &&
as_root mv -v /usr/share/doc/ghostscript/9.52 /usr/share/doc/ghostscript-9.52  &&
as_root rm -rfv /usr/share/doc/ghostscript &&
as_root cp -r examples/ /usr/share/ghostscript/9.52/ &&
as_root tar -xvf ../ghostscript-fonts-std-8.11.tar.gz -C /usr/share/ghostscript --no-same-owner &&
as_root tar -xvf ../gnu-gs-fonts-other-6.0.tar.gz     -C /usr/share/ghostscript --no-same-owner &&
as_root fc-cache -v /usr/share/ghostscript/fonts/ &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
