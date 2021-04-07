#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pygobject-3.40.1
 then
  rm -rf /sources/pygobject-3.40.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/pygobject/3.40/pygobject-3.40.1.tar.xz \
    /sources &&

md5sum --ignore-missing -c ${SCRIPTPATH}/md5-pygobject &&

tar xf /sources/pygobject-3.40.1.tar.xz -C /sources/ &&

cd /sources/pygobject-3.40.1 &&

mv -v tests/test_gdbus.py{,.nouse} &&

mkdir build &&
cd    build &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root ninja install 
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
