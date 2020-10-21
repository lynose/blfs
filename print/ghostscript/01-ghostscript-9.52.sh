#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ghostscript-9.52
 then
  rm -rf /sources/ghostscript-9.52
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs952/ghostscript-9.52.tar.xz \
    --continue --directory-prefix=/sources &&

wget https://downloads.sourceforge.net/gs-fonts/ghostscript-fonts-std-8.11.tar.gz \
    --continue --directory-prefix=/sources &&
wget https://downloads.sourceforge.net/gs-fonts/gnu-gs-fonts-other-6.0.tar.gz \
    --continue --directory-prefix=/sources &&
    
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

make install &&
make soinstall &&
install -v -m644 base/*.h /usr/include/ghostscript &&
ln -sfvn ghostscript /usr/include/ps &&
mv -v /usr/share/doc/ghostscript/9.52 /usr/share/doc/ghostscript-9.52  &&
rm -rfv /usr/share/doc/ghostscript &&
cp -r examples/ /usr/share/ghostscript/9.52/ &&
tar -xvf ../ghostscript-fonts-std-8.11.tar.gz -C /usr/share/ghostscript --no-same-owner &&
tar -xvf ../gnu-gs-fonts-other-6.0.tar.gz     -C /usr/share/ghostscript --no-same-owner &&
fc-cache -v /usr/share/ghostscript/fonts/ &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
