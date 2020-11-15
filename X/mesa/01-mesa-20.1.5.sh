#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mesa-20.1.5
 then
  rm -rf /sources/mesa-20.1.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://mesa.freedesktop.org/archive/mesa-20.1.5.tar.xz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/mesa-20.1.5-add_xdemos-1.patch \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-mesa &&

tar xf /sources/mesa-20.1.5.tar.xz -C /sources/ &&

cd /sources/mesa-20.1.5 &&

patch -Np1 -i ../mesa-20.1.5-add_xdemos-1.patch &&

GALLIUM_DRV="auto" &&
DRI_DRIVERS="auto" &&


mkdir build &&
cd    build &&

meson --prefix=$XORG_PREFIX          \
      -Dbuildtype=release            \
      -Ddri-drivers=$DRI_DRIVERS     \
      -Dgallium-drivers=$GALLIUM_DRV \
      -Dgallium-nine=false           \
      -Dglx=dri                      \
      -Dosmesa=gallium               \
      -Dvalgrind=false               \
      -Dlibunwind=false              \
      ..                             &&

unset GALLIUM_DRV DRI_DRIVERS &&

${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root ninja install &&

as_root install -v -dm755 /usr/share/doc/mesa-20.1.5 &&
as_root cp -rfv ../docs/* /usr/share/doc/mesa-20.1.5 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
