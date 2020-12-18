#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gtk-vnc-1.0.0
 then
  rm -rf /sources/gtk-vnc-1.0.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/gtk-vnc/1.0/gtk-vnc-1.0.0.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-gtk-vnc &&

tar xf /sources/gtk-vnc-1.0.0.tar.xz -C /sources/ &&

cd /sources/gtk-vnc-1.0.0 &&

mkdir build &&
cd    build &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
