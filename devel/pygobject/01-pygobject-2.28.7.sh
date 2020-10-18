#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pygobject-2.28.7
 then
  rm -rf /sources/pygobject-2.28.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://ftp.gnome.org/pub/gnome/sources/pygobject/2.28/pygobject-2.28.7.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum --ignore-missing -c ${SCRIPTPATH}/md5-pygobject &&

tar xf /sources/pygobject-2.28.7.tar.xz -C /sources/ &&

cd /sources/pygobject-2.28.7 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
