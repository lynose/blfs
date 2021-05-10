#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gegl-0.4.30
 then
  as_root rm -rf /sources/gegl-0.4.30
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gimp.org/pub/gegl/0.4/gegl-0.4.30.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gegl &&

tar xf /sources/gegl-0.4.30.tar.xz -C /sources/ &&

cd /sources/gegl-0.4.30 &&

sed '1s@python@&3@' -i tests/python/*.py &&

mkdir build &&
cd    build &&

meson --prefix=/usr -Ddocs=true .. &&
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
