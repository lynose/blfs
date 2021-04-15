#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gsettings-desktop-schemas-40.0
 then
  as_root rm -rf /sources/gsettings-desktop-schemas-40.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gnome.org/sources/gsettings-desktop-schemas/40/gsettings-desktop-schemas-40.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gsettings-desktop-schemas &&

tar xf /sources/gsettings-desktop-schemas-40.0.tar.xz -C /sources/ &&

cd /sources/gsettings-desktop-schemas-40.0 &&

sed -i -r 's:"(/system):"/org/gnome\1:g' schemas/*.in &&

mkdir build &&
cd    build &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
as_root glib-compile-schemas /usr/share/glib-2.0/schemas &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
