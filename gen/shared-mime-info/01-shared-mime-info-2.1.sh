#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/shared-mime-info-2.1
 then
  rm -rf /sources/shared-mime-info-2.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://gitlab.freedesktop.org/xdg/shared-mime-info/uploads/0ee50652091363ab0d17e335e5e74fbe/shared-mime-info-2.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-shared-mime-info &&

tar xf /sources/shared-mime-info-2.1.tar.xz -C /sources/ &&

cd /sources/shared-mime-info-2.1 &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Dupdate-mimedb=true ..  &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
