#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/glib-2.64.4
 then
  rm -rf /sources/glib-2.64.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://ftp.gnome.org/pub/gnome/sources/glib/2.64/glib-2.64.4.tar.xz \
    --continue --directory-prefix=/sources &&
wget http://www.linuxfromscratch.org/patches/blfs/10.0/glib-2.64.4-skip_warnings-1.patch \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-glib &&

tar xf /sources/glib-2.64.4.tar.xz -C /sources/ &&

cd /sources/glib-2.64.4 &&

patch -Np1 -i ../glib-2.64.4-skip_warnings-1.patch &&

mkdir build &&
cd    build &&

meson --prefix=/usr      \
      -Dman=true         \
      -Dselinux=disabled \
      ..                 &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja install &&

mkdir -p /usr/share/doc/glib-2.64.4 &&
cp -r ../docs/reference/{NEWS,gio,glib,gobject} /usr/share/doc/glib-2.64.4
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
