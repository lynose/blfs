#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gcr-3.36.0
 then
  rm -rf /sources/gcr-3.36.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/gcr/3.36/gcr-3.36.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gcr &&

tar xf /sources/gcr-3.36.0.tar.xz -C /sources/ &&

cd /sources/gcr-3.36.0 &&

sed -i -r 's:"(/desktop):"/org/gnome\1:' schema/*.xml &&

sed -i '610 s/;/ = { 0 };/' gck/gck-slot.c &&

mkdir gcr-build &&
cd    gcr-build &&

meson --prefix=/usr -Dgtk_doc=true ..  &&
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
