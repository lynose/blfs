#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/avahi-0.8
 then
  rm -rf /sources/avahi-0.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/lathiat/avahi/releases/download/v0.8/avahi-0.8.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-avahi &&

tar xf /sources/avahi-0.8.tar.gz -C /sources/ &&

cd /sources/avahi-0.8 &&

as_root_groupadd groupadd -fg 84 avahi &&
as_root_useradd useradd -c \"Avahi_Daemon_Owner\" -d /var/run/avahi-daemon -u 84 -g avahi -s /bin/false avahi &&

as_root_groupadd groupadd -fg 86 netdev &&


./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static     \
            --disable-libevent   \
            --disable-mono       \
            --disable-monodoc    \
            --disable-python     \
            --disable-qt3        \
            --disable-qt4        \
            --enable-core-docs   \
            --with-distro=none   \
            --with-systemdsystemunitdir=/lib/systemd/system &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&

as_root systemctl enable avahi-daemon &&
as_root systemctl enable avahi-dnsconfd &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
