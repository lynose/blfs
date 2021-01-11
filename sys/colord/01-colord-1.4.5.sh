#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/colord-1.4.5
 then
  rm -rf /sources/colord-1.4.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/colord/releases/colord-1.4.5.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-colord &&

tar xf /sources/colord-1.4.5.tar.xz -C /sources/ &&

cd /sources/colord-1.4.5 &&

as_root_groupadd groupadd -g 71 colord &&
as_root_useradd useradd -c \"Color_Daemon_Owner\" -d /var/lib/colord -u 71 \
        -g colord -s /bin/false colord &&

mv po/fur.po po/ur.po &&
sed -i 's/fur/ur/' po/LINGUAS &&
        
mkdir build &&
cd build &&

meson --prefix=/usr            \
      --sysconfdir=/etc        \
      --localstatedir=/var     \
      -Ddaemon_user=colord     \
      -Dvapi=true              \
      -Dsystemd=true           \
      -Dlibcolordcompat=true   \
      -Dargyllcms_sensor=false \
      -Dbash_completion=false  \
      -Dman=false ..           &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&

ninja -k 2 test &&
${log} `basename "$0"` " check succeed" blfs_all ||
${log} `basename "$0"` " expected check fail?" blfs_all &&


${log} `basename "$0"` " finished" blfs_all 
