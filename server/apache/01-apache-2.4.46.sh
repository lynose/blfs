#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/httpd-2.4.46
 then
  rm -rf /sources/httpd-2.4.46
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.apache.org/dist/httpd/httpd-2.4.46.tar.bz2 \
        /sources

check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/httpd-2.4.46-blfs_layout-1.patch \
        /sources
        
md5sum -c ${SCRIPTPATH}/md5-apache &&

tar xf /sources/httpd-2.4.46.tar.bz2 -C /sources/ &&

cd /sources/httpd-2.4.46 &&

sudo groupadd -g 25 apache &&
sudo useradd -c "Apache Server" -d /srv/www -g apache -s /bin/false -u 25 apache &&

sed -i 's/lua_resume(a, NULL, b)/lua_resume(a, NULL, b, NULL)/' modules/lua/mod_lua.h &&
patch -Np1 -i ../httpd-2.4.46-blfs_layout-1.patch             &&
sed '/dir.*CFG_PREFIX/s@^@#@' -i support/apxs.in              &&

./configure --enable-authnz-fcgi                              \
            --enable-layout=BLFS                              \
            --enable-mods-shared="all cgi"                    \
            --enable-mpms-shared=all                          \
            --enable-suexec=shared                            \
            --with-apr=/usr/bin/apr-1-config                  \
            --with-apr-util=/usr/bin/apu-1-config             \
            --with-suexec-bin=/usr/lib/httpd/suexec           \
            --with-suexec-caller=apache                       \
            --with-suexec-docroot=/srv/www                    \
            --with-suexec-logfile=/var/log/httpd/suexec.log   \
            --with-suexec-uidmin=100                          \
            --with-suexec-userdir=public_html                 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&


as_root make install  &&

as_root mv -v /usr/sbin/suexec /usr/lib/httpd/suexec &&
as_root chgrp apache           /usr/lib/httpd/suexec &&
as_root chmod 4754             /usr/lib/httpd/suexec &&

as_root chown -v -R apache:apache /srv/www &&

cd blfs-systemd-units &&
as_root make install-httpd &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
