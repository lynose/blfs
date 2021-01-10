#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/glib-2.66.4
 then
  rm -rf /sources/glib-2.66.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/glib/2.66/glib-2.66.4.tar.xz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/glib-2.66.4-skip_warnings-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-glib &&

tar xf /sources/glib-2.66.4.tar.xz -C /sources/ &&

cd /sources/glib-2.66.4 &&

patch -Np1 -i ../glib-2.66.4-skip_warnings-1.patch &&

[ -e /usr/include/glib-2.0 ] && mv -vf /usr/include/glib-2.0{,.old}

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

as_root mkdir -p /usr/share/doc/glib-2.66.4 &&
as_root cp -r ../docs/reference/{NEWS,gio,glib,gobject} /usr/share/doc/glib-2.66.4 &&
if [-f /usr/include/glib-2.0/glib/gurifuncs.h]
then
  as_root rm -f /usr/include/glib-2.0/glib/gurifuncs.h
fi
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
