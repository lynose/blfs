#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ghostscript-9.54.0
 then
  rm -rf /sources/ghostscript-9.54.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`


check_and_download https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9540/ghostscript-9.54.0.tar.xz \
    /sources
check_and_download https://downloads.sourceforge.net/gs-fonts/ghostscript-fonts-std-8.11.tar.gz \
    /sources
check_and_download https://downloads.sourceforge.net/gs-fonts/gnu-gs-fonts-other-6.0.tar.gz \
    /sources

md5sum -c ${SCRIPTPATH}/md5-ghostscript &&

tar xf /sources/ghostscript-9.54.0.tar.xz -C /sources/ &&

cd /sources/ghostscript-9.54.0 &&

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

if [  ! -d /usr/share/doc/ghostscript/9.54.0 ]
 then
  as_root mv -v /usr/share/doc/ghostscript/9.54.0 /usr/share/doc/ghostscript-9.54.0  &&
  as_root cp -r examples/ /usr/share/ghostscript/9.54.0/
fi

as_root rm -rfv /usr/share/doc/ghostscript &&
as_root tar -xvf ../ghostscript-fonts-std-8.11.tar.gz -C /usr/share/ghostscript --no-same-owner &&
as_root tar -xvf ../gnu-gs-fonts-other-6.0.tar.gz     -C /usr/share/ghostscript --no-same-owner &&
as_root fc-cache -v /usr/share/ghostscript/fonts/ &&
if [ ${ENABLE_TEST} == true ]
 then
   gs -q -dBATCH /usr/share/ghostscript/9.54.0/examples/tiger.eps
fi
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
