#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pygobject-3.36.1
 then
  rm -rf /sources/pygobject-3.36.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/pygobject/3.36/pygobject-3.36.1.tar.xz \
    /sources &&

md5sum --ignore-missing -c ${SCRIPTPATH}/md5-pygobject &&

tar xf /sources/pygobject-3.36.1.tar.xz -C /sources/ &&

cd /sources/pygobject-3.36.1 &&

mkdir python2                             &&
pushd python2                             &&
  meson --prefix=/usr -Dpython=python2 .. &&
  ${log} `basename "$0"` " configured python2" blfs_all &&
  ninja                                   &&
  ${log} `basename "$0"` " built python2" blfs_all &&
  ninja -C python2 test &&
  ${log} `basename "$0"` " unexpected check succeed python2" blfs_all
${log} `basename "$0"` " expected check fail? python2" blfs_all &&
popd

mkdir python3                             &&
pushd python3                             &&
  meson --prefix=/usr -Dpython=python3 .. &&
  ${log} `basename "$0"` " configured python3" blfs_all &&
  ninja                                   &&
  ${log} `basename "$0"` " built python3" blfs_all &&
  ninja -C python3 test &&
  ${log} `basename "$0"` " unexpected check succeed python3" blfs_all
${log} `basename "$0"` " expected check fail? python3" blfs_all &&
popd

ninja -C python2 install &&
ninja -C python3 install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
