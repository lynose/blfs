#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/php-8.0.3
 then
  rm -rf /sources/php-8.0.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.php.net/distributions/php-8.0.3.tar.xz \
        /sources &&
check_and_download https://www.php.net/distributions/manual/php_manual_en.html.gz \
        /sources &&
check_and_download https://www.php.net/distributions/manual/php_manual_en.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-php &&

tar xf /sources/php-8.0.3.tar.xz -C /sources/ &&

cd /sources/php-8.0.3 &&



./configure --prefix=/usr                \
            --sysconfdir=/etc            \
            --localstatedir=/var         \
            --datadir=/usr/share/php     \
            --mandir=/usr/share/man      \
            --enable-fpm                 \
            --without-pear               \
            --with-fpm-user=apache       \
            --with-fpm-group=apache      \
            --with-fpm-systemd           \
            --with-config-file-path=/etc \
            --with-zlib                  \
            --enable-bcmath              \
            --with-bz2                   \
            --enable-calendar            \
            --enable-dba=shared          \
            --with-gdbm                  \
            --with-gmp                   \
            --enable-ftp                 \
            --with-gettext               \
            --enable-mbstring            \
            --disable-mbregex            \
            --with-readline          &&
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
as_root install -v -m644 php.ini-production /etc/php.ini &&
if [ ! -d /usr/share/doc/php-8.0.3 ]
 then
  as_root install -v -m755 -d /usr/share/doc/php-8.0.3 &&
fi
as_root install -v -m644    CODING_STANDARDS* EXTENSIONS NEWS README* UPGRADING* \
                    /usr/share/doc/php-8.0.3 &&
if [ -f /etc/php-fpm.conf.default ]; then
  as_root mv -v /etc/php-fpm.conf{.default,} &&
  as_root mv -v /etc/php-fpm.d/www.conf{.default,}
fi

as_root tar -xvf ../php_manual_en.tar.gz \
    -C /usr/share/doc/php-8.0.3 --no-same-owner &&
cp /etc/php.ini /tmp &&
sed -i 's@php/includes"@&\ninclude_path = ".:/usr/lib/php"@' /tmp/php.ini &&
as_root mv /tmp/php.ini /etc &&
as_root chown root:root /etc/php.ini &&

cp /etc/httpd/httpd.conf /tmp &&
sed -i -e '/proxy_module/s/^#//' -e '/proxy_fcgi_module/s/^#//' /tmp/httpd.conf &&
as_root mv /tmp/httpd.conf /etc/httpd/ &&
as_root chown root:root /etc/httpd/httpd.conf &&

cd /usr/src/blfs-systemd-units &&
as_root make install-php-fpm &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
