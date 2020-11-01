#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gimp-2.10.20
 then
  rm -rf /sources/gimp-2.10.20
fi

if test -d /sources/gimp-help-2020-06-08
 then
  rm -rf /sources/gimp-help-2020-06-08
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://download.gimp.org/pub/gimp/v2.10/gimp-2.10.20.tar.bz2 \
    --continue --directory-prefix=/sources &&
wget http://anduin.linuxfromscratch.org/BLFS/gimp/gimp-help-2020-06-08.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-gimp &&

tar xf /sources/gimp-2.10.20.tar.bz2 -C /sources/ &&
tar xf /sources/gimp-help-2020-06-08.tar.xz -C /sources &&

cd /sources/gimp-2.10.20 &&

./configure --prefix=/usr --sysconfdir=/etc &&
${log} `basename "$0"` " configured gimp" blfs_all &&

make &&
${log} `basename "$0"` " built gimp" blfs_all &&

make check &&
${log} `basename "$0"` " unexpected check succeed gimp" blfs_all
${log} `basename "$0"` " expected check fail? gimp" blfs_all &&

make install &&
gtk-update-icon-cache -qtf /usr/share/icons/hicolor &&
update-desktop-database -q &&


${log} `basename "$0"` " installed gimp" blfs_all &&

cd /sources/gimp-help-2020-06-08 &&

ALL_LINGUAS="ca da de el en en_GB es fi fr it ja ko nl nn pt_BR ro ru zh_CN" \
./autogen.sh --prefix=/usr &&
${log} `basename "$0"` " configured gimp-help" blfs_all &&

make &&
${log} `basename "$0"` " built gimp-help" blfs_all &&

make install &&
chown -R root:root /usr/share/gimp/2.0/help &&
${log} `basename "$0"` " installed gimp-help" blfs_all &&


${log} `basename "$0"` " finished" blfs_all 
