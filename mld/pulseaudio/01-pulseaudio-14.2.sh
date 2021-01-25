#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pulseaudio-14.2
 then
  rm -rf /sources/pulseaudio-14.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/pulseaudio/releases/pulseaudio-14.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-pulseaudio &&

tar xf /sources/pulseaudio-14.2.tar.xz -C /sources/ &&

cd /sources/pulseaudio-14.2 &&

mkdir build &&
cd    build &&

meson  --prefix=/usr -Ddatabase=gdbm -Dbluez5=false &&
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
as_root rm -fv /etc/dbus-1/system.d/pulseaudio-system.conf &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
