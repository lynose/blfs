#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gimp-2.10.20
 then
  as_root rm -rf /sources/gimp-2.10.20
fi

if test -d /sources/gimp-help-2020-10-07
 then
  as_root rm -rf /sources/gimp-help-2020-10-07
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gimp.org/pub/gimp/v2.10/gimp-2.10.22.tar.bz2 \
    /sources &&
check_and_download http://anduin.linuxfromscratch.org/BLFS/gimp/gimp-help-2020-10-07.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gimp &&

tar xf /sources/gimp-2.10.20.tar.bz2 -C /sources/ &&
tar xf /sources/gimp-help-2020-10-07.tar.xz -C /sources &&

cd /sources/gimp-2.10.20 &&

./configure --prefix=/usr --sysconfdir=/etc --enable-gtk-doc &&
${log} `basename "$0"` " configured gimp" blfs_all &&

make &&
${log} `basename "$0"` " built gimp" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root gtk-update-icon-cache -qtf /usr/share/icons/hicolor &&
as_root update-desktop-database -q &&


${log} `basename "$0"` " installed gimp" blfs_all &&

cd /sources/gimp-help-2020-10-07 &&

ALL_LINGUAS="ca da de el en en_GB es fi fr it ja ko nl nn pt_BR ro ru zh_CN" \
./autogen.sh --prefix=/usr &&
${log} `basename "$0"` " configured gimp-help" blfs_all &&

make &&
${log} `basename "$0"` " built gimp-help" blfs_all &&

as_root make install &&
as_root chown -R root:root /usr/share/gimp/2.0/help &&
${log} `basename "$0"` " installed gimp-help" blfs_all &&


${log} `basename "$0"` " finished" blfs_all 
