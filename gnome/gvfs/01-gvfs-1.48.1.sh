#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gvfs-1.48.1
 then
  as_root rm -rf /sources/gvfs-1.48.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gnome.org/sources/gvfs/1.48/gvfs-1.48.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gvfs &&

tar xf /sources/gvfs-1.48.1.tar.xz -C /sources/ &&

cd /sources/gvfs-1.48.1 &&

mkdir build &&
cd    build &&

meson --prefix=/usr     \
      -Dgphoto2=false   \
      -Dafc=false       \
      -Dbluray=false    \
      -Dmtp=false       \
      -Dnfs=false       \
      -Dsmb=false  .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
as_root glib-compile-schemas /usr/share/glib-2.0/schemas &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
