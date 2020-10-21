#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gtk-doc-1.32
 then
  rm -rf /sources/gtk-doc-1.32
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://ftp.gnome.org/pub/gnome/sources/gtk-doc/1.32/gtk-doc-1.32.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-gtk-doc &&

tar xf /sources/gtk-doc-1.32.tar.xz -C /sources/ &&

cd /sources/gtk-doc-1.32 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&

# TODO optional packages
#check after install
# make check &&
# ${log} `basename "$0"` " unexpected check succeed" blfs_all
# ${log} `basename "$0"` " expected check fail?" blfs_all &&

${log} `basename "$0"` " finished" blfs_all 
