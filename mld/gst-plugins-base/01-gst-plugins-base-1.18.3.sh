#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gst-plugins-base-1.18.3
 then
  rm -rf /sources/gst-plugins-base-1.18.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.18.3.tar.xz \
    /sources

md5sum -c ${SCRIPTPATH}/md5-gst-plugins-base &&

tar xf /sources/gst-plugins-base-1.18.3.tar.xz -C /sources/ &&

cd /sources/gst-plugins-base-1.18.3 &&

mkdir build &&
cd    build &&

meson  --prefix=/usr       \
       -Dbuildtype=release \
       -Dpackage-origin=http://www.linuxfromscratch.org/blfs/view/svn/ \
       -Dpackage-name="GStreamer 1.18.3 BLFS" \
       --wrap-mode=nodownload &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ENABLE_TEST == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
