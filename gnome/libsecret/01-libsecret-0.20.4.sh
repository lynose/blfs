#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libsecret-0.20.4
 then
  rm -rf /sources/libsecret-0.20.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gnome.org/sources/libsecret/0.20/libsecret-0.20.4.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libsecret &&

tar xf /sources/libsecret-0.20.4.tar.xz -C /sources/ &&

cd /sources/libsecret-0.20.4 &&

mkdir bld &&
cd bld &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
