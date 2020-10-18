#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gsettings-desktop-schemas-3.36.1
 then
  rm -rf /sources/gsettings-desktop-schemas-3.36.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://ftp.gnome.org/pub/gnome/sources/gsettings-desktop-schemas/3.36/gsettings-desktop-schemas-3.36.1.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-gsettings-desktop-schemas &&

tar xf /sources/gsettings-desktop-schemas-3.36.1.tar.xz -C /sources/ &&

cd /sources/gsettings-desktop-schemas-3.36.1 &&

sed -i -r 's:"(/system):"/org/gnome\1:g' schemas/*.in &&

mkdir build &&
cd    build &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja install &&
glib-compile-schemas /usr/share/glib-2.0/schemas &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
