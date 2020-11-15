#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gstreamer-1.16.2
 then
  rm -rf /sources/gstreamer-1.16.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.16.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gstreamer &&

tar xf /sources/gstreamer-1.16.2.tar.xz -C /sources/ &&

cd /sources/gstreamer-1.16.2 &&

mkdir build &&
cd    build &&

meson  --prefix=/usr       \
       -Dbuildtype=release \
       -Dgst_debug=false   \
       -Dpackage-origin=http://www.linuxfromscratch.org/blfs/view/svn/ \
       -Dpackage-name="GStreamer 1.16.2 BLFS" &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
