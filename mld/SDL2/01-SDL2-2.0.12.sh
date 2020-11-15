#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/SDL2-2.0.12
 then
  rm -rf /sources/SDL2-2.0.12
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.libsdl.org/release/SDL2-2.0.12.tar.gz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/SDL2-2.0.12-opengl_include_fix-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-SDL2 &&

tar xf /sources/SDL2-2.0.12.tar.gz -C /sources/ &&

cd /sources/SDL2-2.0.12 &&

case $(uname -m) in
   i?86) patch -Np1 -i ../SDL2-2.0.12-opengl_include_fix-1.patch ;;
esac

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
pushd docs  &&
  doxygen   &&
popd
${log} `basename "$0"` " built" blfs_all &&

as_root make install              &&
rm -v /usr/lib/libSDL2*.a &&
as_root install -v -m755 -d        /usr/share/doc/SDL2-2.0.12/html &&
as_root cp -Rv  docs/output/html/* /usr/share/doc/SDL2-2.0.12/html &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
