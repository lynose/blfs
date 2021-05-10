#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/librsvg-2.50.5
 then
  as_root rm -rf /sources/librsvg-2.50.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/librsvg/2.50/librsvg-2.50.5.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-librsvg &&

tar xf /sources/librsvg-2.50.5.tar.xz -C /sources/ &&

cd /sources/librsvg-2.50.5 &&

./configure --prefix=/usr    \
            --enable-vala    \
            --disable-static \
            --enable-gtk-doc \
            --docdir=/usr/share/doc/librsvg-2.50.5 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root gdk-pixbuf-query-loaders --update-cache &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
