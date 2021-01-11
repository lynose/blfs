#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/freetype-2.10.4
 then
  rm -rf /sources/freetype-2.10.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`


check_and_download https://downloads.sourceforge.net/freetype/freetype-2.10.4.tar.xz \
    /sources &&
check_and_download https://downloads.sourceforge.net/freetype/freetype-doc-2.10.4.tar.xz \
    /sources &&


md5sum -c ${SCRIPTPATH}/md5-freetype &&

tar xf /sources/freetype-2.10.4.tar.xz -C /sources/ &&

cd /sources/freetype-2.10.4 &&

tar -xf ../freetype-doc-2.10.4.tar.xz --strip-components=2 -C docs &&

sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg &&

sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h  &&

./configure --prefix=/usr               \
            --enable-freetype-config    \
            --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root install -v -m755 -d /usr/share/doc/freetype-2.10.4 &&
as_root cp -v -R docs/*     /usr/share/doc/freetype-2.10.4 &&
as_root rm -v /usr/share/doc/freetype-2.10.4/freetype-config.1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
