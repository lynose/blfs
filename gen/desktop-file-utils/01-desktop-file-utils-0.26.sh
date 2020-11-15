#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/desktop-file-utils-0.26
 then
  rm -rf /sources/desktop-file-utils-0.26
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-0.26.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-desktop-file-utils &&

tar xf /sources/desktop-file-utils-0.26.tar.xz -C /sources/ &&

cd /sources/desktop-file-utils-0.26 &&

mkdir build &&
cd    build &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
as_root install -vdm755 /usr/share/applications &&
update-desktop-database /usr/share/applications &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
