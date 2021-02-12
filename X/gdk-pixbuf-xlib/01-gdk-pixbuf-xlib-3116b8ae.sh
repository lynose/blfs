#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gdk-pixbuf-xlib-3116b8ae
 then
  rm -rf /sources/gdk-pixbuf-xlib-3116b8ae
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://anduin.linuxfromscratch.org/BLFS/gdk-pixbuf-xlib/gdk-pixbuf-xlib-3116b8ae.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-gdk-pixbuf-xlib &&

tar xf /sources/gdk-pixbuf-xlib-3116b8ae.tar.xz -C /sources/ &&

cd /sources/gdk-pixbuf-xlib-3116b8ae &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Dgtk_doc=true .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
