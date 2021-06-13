#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/dhcp-4.4.2-P1
 then
  rm -rf /sources/dhcp-4.4.2-P1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download ftp://ftp.isc.org/isc/dhcp/4.4.2-P1/dhcp-4.4.2-P1.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-dhcp &&

tar xf /sources/dhcp-4.4.2-P1.tar.gz -C /sources/ &&

cd /sources/dhcp-4.4.2-P1 &&

sed -i '/o.*dhcp_type/d' server/mdb.c &&
sed -r '/u.*(local|remote)_port/d'    \
    -i client/dhclient.c              \
       relay/dhcrelay.c &&

( export CFLAGS="$CFLAGS -Wall -fno-strict-aliasing                 \
        -D_PATH_DHCLIENT_SCRIPT='\"/sbin/dhclient-script\"'         \
        -D_PATH_DHCPD_CONF='\"/etc/dhcp/dhcpd.conf\"'               \
        -D_PATH_DHCLIENT_CONF='\"/etc/dhcp/dhclient.conf\"'"        &&

./configure --prefix=/usr                                           \
            --sysconfdir=/etc/dhcp                                  \
            --localstatedir=/var                                    \
            --with-srv-lease-file=/var/lib/dhcpd/dhcpd.leases       \
            --with-srv6-lease-file=/var/lib/dhcpd/dhcpd6.leases     \
            --with-cli-lease-file=/var/lib/dhclient/dhclient.leases \
            --with-cli6-lease-file=/var/lib/dhclient/dhclient6.leases
) &&
${log} `basename "$0"` " configured" blfs_all &&

make -j1 &&
${log} `basename "$0"` " built" blfs_all &&

make install         &&
install -v -m755 client/scripts/linux /usr/sbin/dhclient-script &&

as_root install -vdm755 /etc/dhcp &&
as_root cat > /etc/dhcp/dhclient.conf << "EOF"
# Begin /etc/dhcp/dhclient.conf
#
# Basic dhclient.conf(5)

#prepend domain-name-servers 127.0.0.1;
request subnet-mask, broadcast-address, time-offset, routers,
        domain-name, domain-name-servers, domain-search, host-name,
        netbios-name-servers, netbios-scope, interface-mtu,
        ntp-servers;
require subnet-mask, domain-name-servers;
#timeout 60;
#retry 60;
#reboot 10;
#select-timeout 5;
#initial-interval 2;

# End /etc/dhcp/dhclient.conf
EOF
as_root install -v -dm 755 /var/lib/dhclient &&
cd /usr/src/blfs-systemd-units &&
make install-dhclient &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
