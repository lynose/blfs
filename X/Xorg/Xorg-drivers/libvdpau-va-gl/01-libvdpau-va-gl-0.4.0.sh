#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libvdpau-va-gl-0.4.0
 then
  rm -rf /sources/libvdpau-va-gl-0.4.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/i-rinat/libvdpau-va-gl/archive/v0.4.0/libvdpau-va-gl-0.4.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libvdpau-va-gl &&

tar xf /sources/libvdpau-va-gl-0.4.0.tar.gz -C /sources/ &&

cd /sources/libvdpau-va-gl-0.4.0 &&

mkdir build &&
cd    build &&

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$XORG_PREFIX .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

as_root make install &&
echo "export VDPAU_DRIVER=va_gl" >> /etc/profile.d/xorg.sh &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
