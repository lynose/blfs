#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/scons-4.0.1
 then
  rm -rf /sources/scons-4.0.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/scons/scons-4.0.1.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-scons &&

tar xf /sources/scons-4.0.1.tar.gz -C /sources/ &&

cd /sources/scons-4.0.1 &&

sed -i 's/env python/&3/' SCons/Utilities/*.py     &&
${log} `basename "$0"` " configured" blfs_all &&

as_root python3 setup.py install --prefix=/usr  \
                         --optimize=1   \
                         --install-data=/usr/share &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
