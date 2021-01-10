#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/inih-r52
 then
  rm -rf /sources/inih-r52
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/benhoyt/inih/archive/r52/inih-r52.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-inih &&

tar xf /sources/inih-r52.tar.gz -C /sources/ &&

cd /sources/inih-r52 &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Ddefault_library=shared -Ddistro_install=true .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
