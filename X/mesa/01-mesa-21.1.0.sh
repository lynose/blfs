#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mesa-21.1.0
 then
  rm -rf /sources/mesa-21.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://mesa.freedesktop.org/archive/mesa-21.1.0.tar.xz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/mesa-21.1.0-add_xdemos-1.patch \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-mesa &&

tar xf /sources/mesa-21.1.0.tar.xz -C /sources/ &&

cd /sources/mesa-21.1.0 &&

patch -Np1 -i ../mesa-21.1.0-add_xdemos-1.patch &&

sed '1s/python/&3/' -i bin/symbols-check.py &&

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
      -Dosmesa=true               \
      -Dvalgrind=true               \
      -Dlibunwind=disabled              \
      ..                             &&

unset GALLIUM_DRV DRI_DRIVERS &&

${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi


as_root ninja install &&

as_root install -v -dm755 /usr/share/doc/mesa-21.1.0 &&
as_root cp -rfv ../docs/* /usr/share/doc/mesa-21.1.0 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
