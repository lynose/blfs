#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/freetype-2.10.2
 then
  rm -rf /sources/freetype-2.10.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/freetype-2.10.2.tar.xz ];  
 then
  wget https://downloads.sourceforge.net/freetype/freetype-2.10.2.tar.xz \
    --continue --directory-prefix=/sources
fi
if [ ! -f /sources/freetype-doc-2.10.2.tar.xz ];  
 then
  wget https://downloads.sourceforge.net/freetype/freetype-doc-2.10.2.tar.xz \
    --continue --directory-prefix=/sources
fi
md5sum -c ${SCRIPTPATH}/md5-freetype &&

tar xf /sources/freetype-2.10.2.tar.xz -C /sources/ &&

cd /sources/freetype-2.10.2 &&

tar -xf ../freetype-doc-2.10.2.tar.xz --strip-components=2 -C docs &&

sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg &&

sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h  &&

./configure --prefix=/usr               \
            --enable-freetype-config    \
            --disable-static            \
            --without-harfbuzz &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
install -v -m755 -d /usr/share/doc/freetype-2.10.2 &&
cp -v -R docs/*     /usr/share/doc/freetype-2.10.2 &&
rm -v /usr/share/doc/freetype-2.10.2/freetype-config.1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
