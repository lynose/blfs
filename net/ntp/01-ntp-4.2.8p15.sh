#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/ntp-4.2.8p15
 then
  rm -rf /sources/ntp-4.2.8p15
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p15.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-ntp &&

tar xf /sources/ntp-4.2.8p15.tar.gz -C /sources/ &&

as_root groupadd -g 87 ntp &&
as_root useradd -c "Network Time Protocol" -d /var/lib/ntp -u 87 -g ntp -s /bin/false ntp &&

cd /sources/ntp-4.2.8p15 &&

sed -e 's/"(\\S+)"/"?([^\\s"]+)"?/' \
    -i scripts/update-leap/update-leap.in &&

./configure CFLAGS="-O2 -g -fPIC -fcommon $CFLAGS" \
            --prefix=/usr         \
            --bindir=/usr/sbin    \
            --sysconfdir=/etc     \
            --enable-linuxcaps    \
            --with-lineeditlibs=readline \
            --docdir=/usr/share/doc/ntp-4.2.8p15 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root install -v -o ntp -g ntp -d /var/lib/ntp &&

cat > ./ntp.conf << "EOF" &&

# Europe
server 0.europe.pool.ntp.org

driftfile /var/lib/ntp/ntp.drift
pidfile   /var/run/ntpd.pid

leapfile  /var/lib/ntp/ntp.leapseconds
EOF
as_root mv -v ./ntp.conf /etc/ntp.conf &&

cat >> ./ntp.conf << "EOF" &&
# Security session
restrict    default limited kod nomodify notrap nopeer noquery
restrict -6 default limited kod nomodify notrap nopeer noquery

restrict 127.0.0.1
restrict ::1
EOF
as_root mv -v ./ntp.conf /etc/ntp.conf &&

cd /usr/src/blfs-systemd-units &&
make install-ntpd &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
