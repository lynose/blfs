#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gst-plugins-good-1.18.4
 then
  rm -rf /sources/gst-plugins-good-1.18.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.18.4.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gst-plugins-good &&

tar xf /sources/gst-plugins-good-1.18.4.tar.xz -C /sources/ &&

cd /sources/gst-plugins-good-1.18.4 &&

mkdir build &&
cd    build &&

meson  --prefix=/usr       \
       -Dbuildtype=release \
       -Dpackage-origin=http://www.linuxfromscratch.org/blfs/view/svn/ \
       -Dpackage-name="GStreamer 1.18.4 BLFS" &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&
if [ ${ENABLE_TEST} == true ]
 then
    ninja test &&
    ${log} `basename "$0"` " check succeed" blfs_all ||
    ${log} `basename "$0"` " expected check fail?" blfs_all
fi
as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
