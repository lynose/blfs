#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gvfs-1.44.1
 then
  rm -rf /sources/gvfs-1.44.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/gvfs/1.44/gvfs-1.44.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gvfs &&

tar xf /sources/gvfs-1.44.1.tar.xz -C /sources/ &&

cd /sources/gvfs-1.44.1 &&

mkdir build &&
cd    build &&

meson --prefix=/usr     \
      --sysconfdir=/etc \
      -Dfuse=false      \
      -Dgphoto2=false   \
      -Dafc=false       \
      -Dbluray=false    \
      -Dnfs=false       \
      -Dmtp=false       \
      -Dsmb=false       \
      -Dgoa=false       \
      -Dgoogle=false    ..  &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
as_root glib-compile-schemas /usr/share/glib-2.0/schemas &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
