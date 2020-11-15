#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/SDL-1.2.15
 then
  rm -rf /sources/SDL-1.2.15
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.libsdl.org/release/SDL-1.2.15.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-SDL &&

tar xf /sources/SDL-1.2.15.tar.gz -C /sources/ &&

cd /sources/SDL-1.2.15 &&

sed -e '/_XData32/s:register long:register _Xconst long:' \
    -i src/video/x11/SDL_x11sym.h &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&

as_root install -v -m755 -d /usr/share/doc/SDL-1.2.15/html &&
as_root install -v -m644    docs/html/*.html \
                    /usr/share/doc/SDL-1.2.15/html &&
${log} `basename "$0"` " installed" blfs_all &&                    
${log} `basename "$0"` " finished" blfs_all 
