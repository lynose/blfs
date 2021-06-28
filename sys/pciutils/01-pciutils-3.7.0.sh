#!/bin/bash

${log} `basename "$0"` " started" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

if test -d /sources/pciutils-3.7.0
 then
  rm -rf /sources/pciutils-3.7.0
fi

${log} `basename "$0"` " Downloading" blfs_all &&
check_and_download https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.7.0.tar.xz /sources &&

md5sum -c ${SCRIPTPATH}/md5-pciutils &&

tar xf /sources/pciutils-3.7.0.tar.xz -C /sources/ &&

cd /sources/pciutils-3.7.0 &&

make PREFIX=/usr                \
     SHAREDIR=/usr/share/hwdata \
     SHARED=yes && 
${log} `basename "$0"` " build" blfs_all &&

as_root make PREFIX=/usr                \
     SHAREDIR=/usr/share/hwdata \
     SHARED=yes                 \
     install install-lib        &&

as_root chmod -v 755 /usr/lib/libpci.so &&
${log} `basename "$0"` " installed" blfs_all &&

as_root cat > /tmp/update-pciids.service << "EOF" &&
[Unit]
Description=Update pci.ids file
Documentation=man:update-pciids(8)
DefaultDependencies=no
After=local-fs.target network-online.target
Before=shutdown.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/sbin/update-pciids
EOF

as_root install -m644 --owner=root /tmp/update-pciids.service /usr/lib/systemd/system/update-pciids.service &&

as_root cat > /tmp/update-pciids.timer << "EOF" &&
[Unit]
Description=Update pci.ids file weekly

[Timer]
OnCalendar=Sun 02:30:00
Persistent=true

[Install]
WantedBy=timers.target
EOF
as_root install -m644 --owner=root /tmp/update-pciids.timer /usr/lib/systemd/system/update-pciids.timer &&
as_root systemctl enable update-pciids.timer &&
${log} `basename "$0"` " update pciids" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
