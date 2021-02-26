#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gexiv2-0.12.2
 then
  rm -rf /sources/gexiv2-0.12.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gnome.org/sources/gexiv2/0.12/gexiv2-0.12.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gexiv2 &&

tar xf /sources/gexiv2-0.12.2.tar.xz -C /sources/ &&

cd /sources/gexiv2-0.12.2 &&

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


as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
