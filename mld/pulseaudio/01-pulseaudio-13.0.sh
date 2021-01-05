#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pulseaudio-13.0
 then
  rm -rf /sources/pulseaudio-13.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/pulseaudio/releases/pulseaudio-13.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-pulseaudio &&

tar xf /sources/pulseaudio-13.0.tar.xz -C /sources/ &&

cd /sources/pulseaudio-13.0 &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-bluez5     \
            --disable-rpath  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root rm -fv /etc/dbus-1/system.d/pulseaudio-system.conf &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
