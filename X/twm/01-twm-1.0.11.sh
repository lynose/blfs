#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/twm-1.0.11
 then
  rm -rf /sources/twm-1.0.11
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.x.org/pub/individual/app/twm-1.0.11.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-twm &&

tar xf /sources/twm-1.0.11.tar.xz -C /sources/ &&

cd /sources/twm-1.0.11 &&

sed -i -e '/^rcdir =/s,^\(rcdir = \).*,\1/etc/X11/app-defaults,' src/Makefile.in &&
./configure $XORG_CONFIG &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
