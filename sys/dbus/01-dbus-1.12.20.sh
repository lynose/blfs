#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/dbus-1.12.20
 then
  rm -rf /sources/dbus-1.12.20
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://dbus.freedesktop.org/releases/dbus/dbus-1.12.20.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-dbus &&

tar xf /sources/dbus-1.12.20.tar.gz -C /sources/ &&

cd /sources/dbus-1.12.20 &&

./configure --prefix=/usr                        \
            --sysconfdir=/etc                    \
            --localstatedir=/var                 \
            --enable-user-session                \
            --disable-xml-docs                   \
            --disable-static                     \
            --docdir=/usr/share/doc/dbus-1.12.20 \
            --with-console-auth-dir=/run/console \
            --with-system-pid-file=/run/dbus/pid \
            --with-system-socket=/run/dbus/system_bus_socket  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
mv -v /usr/lib/libdbus-1.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libdbus-1.so) /usr/lib/libdbus-1.so &&
chown -v root:messagebus /usr/libexec/dbus-daemon-launch-helper &&
chmod -v      4750       /usr/libexec/dbus-daemon-launch-helper &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
