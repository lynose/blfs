#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/meson-0.57.1
 then
  rm -rf /sources/meson-0.57.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/mesonbuild/meson/releases/download/0.57.1/meson-0.57.1.tar.gz \
        /sources &&

check_and_download http://www.linuxfromscratch.org/patches/lfs/development/meson-0.57.1-upstream_fix-1.patch \
        /sources &&

        
        
md5sum -c ${SCRIPTPATH}/md5-meson &&

tar xf /sources/meson-0.57.1.tar.gz -C /sources/ &&

cd /sources/meson-0.57.1 &&

patch -Np1 -i ../meson-0.57.1-upstream_fix-1.patch &&

${log} `basename "$0"` " configured" blfs_all &&

python3 setup.py build &&
${log} `basename "$0"` " built" blfs_all &&

python3 setup.py install --root=dest &&
as_root cp -rv dest/* / &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
