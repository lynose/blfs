#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/glib-2.68.0
 then
  as_root rm -rf /sources/glib-2.68.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/glib/2.68/glib-2.68.0.tar.xz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/glib-2.68.0-skip_warnings-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-glib &&

tar xf /sources/glib-2.68.0.tar.xz -C /sources/ &&

cd /sources/glib-2.68.0 &&

patch -Np1 -i ../glib-2.68.0-skip_warnings-1.patch &&

if [ -e /usr/include/glib-2.0 ]; then
    rm -rf /usr/include/glib-2.0.old &&
    mv -vf /usr/include/glib-2.0{,.old}
fi

mkdir build &&
cd    build &&

meson --prefix=/usr      \
      -Dman=true         \
      -Dselinux=disabled \
      -Dgtk_doc=true     \
      ..                 &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&

as_root mkdir -p /usr/share/doc/glib-2.68.0 &&
as_root cp -r ../docs/reference/{NEWS,gio,glib,gobject} /usr/share/doc/glib-2.68.0 &&
if [ -f /usr/include/glib-2.0/glib/gurifuncs.h ]
then
  as_root rm -f /usr/include/glib-2.0/glib/gurifuncs.h
fi
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
