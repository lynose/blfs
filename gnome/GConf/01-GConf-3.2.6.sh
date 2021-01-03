#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/GConf-3.2.6
 then
  rm -rf /sources/GConf-3.2.6
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/GConf/3.2/GConf-3.2.6.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-GConf &&

tar xf /sources/GConf-3.2.6.tar.xz -C /sources/ &&

cd /sources/GConf-3.2.6 &&



./configure --prefix=/usr \
            --sysconfdir=/etc \
            --disable-orbit \
            --disable-static  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root ln -sf gconf.xml.defaults /etc/gconf/gconf.xml.system &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
