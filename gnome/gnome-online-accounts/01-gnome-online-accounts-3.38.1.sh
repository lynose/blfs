#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gnome-online-accounts-3.38.1
 then
  rm -rf /sources/gnome-online-accounts-3.38.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://download.gnome.org/sources/gnome-online-accounts/3.38/gnome-online-accounts-3.38.1.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gnome-online-accounts &&

tar xf /sources/gnome-online-accounts-3.38.1.tar.xz -C /sources/ &&

cd /sources/gnome-online-accounts-3.38.1 &&

./configure --prefix=/usr \
            --disable-static \
            --with-google-client-secret=5ntt6GbbkjnTVXx-MSxbmx5e \
            --with-google-client-id=595013732528-llk8trb03f0ldpqq6nprjp1s79596646.apps.googleusercontent.com \
            --enable-kerberos \
            --enable-gtk-doc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
