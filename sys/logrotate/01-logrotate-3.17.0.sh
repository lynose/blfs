#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/logrotate-3.17.0
 then
  rm -rf /sources/logrotate-3.17.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/logrotate/logrotate/releases/download/3.17.0/logrotate-3.17.0.tar.xz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-logrotate &&

tar xf /sources/logrotate-3.17.0.tar.xz -C /sources/ &&

cd /sources/logrotate-3.17.0 &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&

cat > ./logrotate.conf << EOF &&
# Begin /etc/logrotate.conf

# Rotate log files weekly
weekly

# Don't mail logs to anybody
nomail

# If the log file is empty, it will not be rotated
notifempty

# Number of backups that will be kept
# This will keep the 2 newest backups only
rotate 2

# Create new empty files after rotating old ones
# This will create empty log files, with owner
# set to root, group set to sys, and permissions 664
create 0664 root sys

# Compress the backups with gzip
compress

# No packages own lastlog or wtmp -- rotate them here
/var/log/wtmp {
    monthly
    create 0664 root utmp
    rotate 1
}

/var/log/lastlog {
    monthly
    rotate 1
}

# Some packages drop log rotation info in this directory
# so we include any file in it.
include /etc/logrotate.d

# End /etc/logrotate.conf
EOF

as_root mv -v ./logrotate.conf /etc/logrotate.conf &&
as_root chown root:root /etc/logrotate.conf &&
as_root chmod -v 0644 /etc/logrotate.conf &&
as_root mkdir -p /etc/logrotate.d &&

cat > ./sys.log << EOF
/var/log/sys.log {
   # If the log file is larger than 100kb, rotate it
   size   100k
   rotate 5
   weekly
   postrotate
      /bin/killall -HUP syslogd
   endscript
}
EOF
as_root mv -v ./sys.log /etc/logrotate.d/sys.log &&
as_root chown -v root:root /etc/logrotate.d/sys.log &&
as_root chmod -v 0644 /etc/logrotate.d/sys.log &&

cat > ./logrotate.service << "EOF" &&
[Unit]
Description=Runs the logrotate command
Documentation=man:logrotate(8)
DefaultDependencies=no
After=local-fs.target
Before=shutdown.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/sbin/logrotate /etc/logrotate.conf
EOF

as_root mv -v ./logrotate.service /lib/systemd/system/logrotate.service &&
as_root chown root:root /lib/systemd/system/logrotate.service &&

cat > ./logrotate.timer << "EOF" &&
[Unit]
Description=Runs the logrotate command daily at 3:00 AM

[Timer]
OnCalendar=*-*-* 3:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

as_root mv -v ./logrotate.timer /lib/systemd/system/logrotate.timer &&
as_root chown root:root /lib/systemd/system/logrotate.timer &&
as_root systemctl enable logrotate.timer &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
