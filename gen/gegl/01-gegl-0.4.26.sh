#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gegl-0.4.26
 then
  rm -rf /sources/gegl-0.4.26
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gimp.org/pub/gegl/0.4/gegl-0.4.26.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gegl &&

tar xf /sources/gegl-0.4.26.tar.xz -C /sources/ &&

cd /sources/gegl-0.4.26 &&

sed '1s@python@&3@' -i tests/python/*.py &&

mkdir build &&
cd    build &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

ninja test &&
${log} `basename "$0"` " check succeed" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
