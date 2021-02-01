#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gtk-doc-1.33.2
 then
  rm -rf /sources/gtk-doc-1.33.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/gtk-doc/1.33/gtk-doc-1.33.2.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gtk-doc &&

tar xf /sources/gtk-doc-1.33.2.tar.xz -C /sources/ &&

cd /sources/gtk-doc-1.33.2 &&

autoreconf -fiv           &&
./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

${log} `basename "$0"` " finished" blfs_all 
