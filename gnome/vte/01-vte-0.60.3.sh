#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/vte-0.60.3
 then
  rm -rf /sources/vte-0.60.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/vte/0.60/vte-0.60.3.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-vte &&

tar xf /sources/vte-0.60.3.tar.xz -C /sources/ &&

cd /sources/vte-0.60.3 &&

mkdir build &&
cd    build &&

meson  --prefix=/usr --sysconfdir=/etc -Dfribidi=false .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja test &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root ninja install &&
as_root rm -v /etc/profile.d/vte.* &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
