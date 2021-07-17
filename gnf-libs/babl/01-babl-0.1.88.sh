#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/babl-0.1.88
 then
  rm -rf /sources/babl-0.1.88
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gimp.org/pub/babl/0.1/babl-0.1.88.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-babl &&

tar xf /sources/babl-0.1.88.tar.xz -C /sources/ &&

cd /sources/babl-0.1.88 &&

mkdir bld &&
cd    bld &&

meson --prefix=/usr ..  &&
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

as_root install -v -m755 -d                         /usr/share/gtk-doc/html/babl/graphics &&
as_root install -v -m644 docs/*.{css,html}          /usr/share/gtk-doc/html/babl          &&
as_root install -v -m644 docs/graphics/*.{html,svg} /usr/share/gtk-doc/html/babl/graphics &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
