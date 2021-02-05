#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/SCons-4.1.0
 then
  as_root rm -rf /sources/SCons-4.1.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://downloads.sourceforge.net/scons/scons-4.1.0.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-scons &&

tar xf /sources/scons-4.1.0.tar.gz -C /sources/ &&

cd /sources/SCons-4.1.0 &&

as_root sed -i 's/env python/&3/' SCons/Utilities/*.py  &&
as_root sed -i 's:build/doc/man/::' setup.cfg           &&
${log} `basename "$0"` " configured" blfs_all &&

as_root python3 setup.py install --prefix=/usr  \
                         --optimize=1   \
                         --install-data=/usr/share/man/man1 &&
as_root cp scons{,ign}.1 /usr/share/man/man1
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
