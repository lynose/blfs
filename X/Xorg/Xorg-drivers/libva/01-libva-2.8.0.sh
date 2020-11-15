#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libva-2.8.0
 then
  rm -rf /sources/libva-2.8.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/intel/libva/releases/download/2.8.0/libva-2.8.0.tar.bz2 \
    /sources &&
check_and_download https://github.com/intel/intel-vaapi-driver/releases/download/2.4.1/intel-vaapi-driver-2.4.1.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libva &&

tar xf /sources/libva-2.8.0.tar.bz2 -C /sources/ &&

cd /sources/libva-2.8.0 &&

./configure $XORG_CONFIG  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&


tar -xvf ../intel-vaapi-driver-2.4.1.tar.bz2 &&
cd intel-vaapi-driver-2.4.1 &&

./configure $XORG_CONFIG  &&
${log} `basename "$0"` " configured Intel vaapi" blfs_all &&

make &&
${log} `basename "$0"` " built Intel vaapi" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed Intel vaapi" blfs_all &&

${log} `basename "$0"` " finished" blfs_all 
