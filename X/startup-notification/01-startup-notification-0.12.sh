#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/startup-notification-0.12
 then
  rm -rf /sources/startup-notification-0.12
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/startup-notification/releases/startup-notification-0.12.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-startup-notification &&

tar xf /sources/startup-notification-0.12.tar.gz -C /sources/ &&

cd /sources/startup-notification-0.12 &&

./configure --prefix=/usr --disable-static &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root install -v -m644 -D doc/startup-notification.txt \
    /usr/share/doc/startup-notification-0.12/startup-notification.txt &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
