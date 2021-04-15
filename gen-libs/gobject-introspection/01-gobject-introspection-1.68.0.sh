#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gobject-introspection-1.68.0
 then
  as_root rm -rf /sources/gobject-introspection-1.68.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.68/gobject-introspection-1.68.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gobject-introspection &&

tar xf /sources/gobject-introspection-1.68.0.tar.xz -C /sources/ &&

cd /sources/gobject-introspection-1.68.0 &&

mkdir build &&
cd    build &&

meson --prefix=/usr \
      -Dgtk_doc=true \
      -Dcairo=enabled \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test -k0 &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
