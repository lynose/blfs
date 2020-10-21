#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gnome-keyring-3.36.0
 then
  rm -rf /sources/gnome-keyring-3.36.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://ftp.gnome.org/pub/gnome/sources/gnome-keyring/3.36/gnome-keyring-3.36.0.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-gnome-keyring &&

tar xf /sources/gnome-keyring-3.36.0.tar.xz -C /sources/ &&

cd /sources/gnome-keyring-3.36.0 &&

sed -i -r 's:"(/desktop):"/org/gnome\1:' schema/*.xml &&

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --with-pam-dir=/lib/security &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

# make check &&
# ${log} `basename "$0"` " unexpected check succeed" blfs_all
# ${log} `basename "$0"` " expected check fail?" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
