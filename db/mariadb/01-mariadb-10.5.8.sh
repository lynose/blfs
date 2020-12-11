#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mariadb-10.5.8
 then
  rm -rf /sources/mariadb-10.5.8
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download ftp://mirrors.fe.up.pt/pub/mariadb/mariadb-10.5.8/source/mariadb-10.5.8.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-mariadb &&

tar xf /sources/mariadb-10.5.8.tar.gz -C /sources/ &&

cd /sources/mariadb-10.5.8 &&

#sudo groupadd -g 40 mysql &&
#sudo useradd -c "MySQL Server" -d /srv/mysql -g mysql -s /bin/false -u 40 mysql &&

mkdir build &&
cd    build &&

cmake -DCMAKE_BUILD_TYPE=Release                      \
      -DCMAKE_INSTALL_PREFIX=/usr                     \
      -DPLUGIN_AUTH_GSSAPI=DYNAMIC       \
      -DINSTALL_DOCDIR=share/doc/mariadb-10.5.8       \
      -DINSTALL_DOCREADMEDIR=share/doc/mariadb-10.5.8 \
      -DINSTALL_MANDIR=share/man                      \
      -DINSTALL_MYSQLSHAREDIR=share/mysql             \
      -DINSTALL_MYSQLTESTDIR=share/mysql/test         \
      -DINSTALL_PLUGINDIR=lib/mysql/plugin            \
      -DINSTALL_SBINDIR=sbin                          \
      -DINSTALL_SCRIPTDIR=bin                         \
      -DINSTALL_SQLBENCHDIR=share/mysql/bench         \
      -DINSTALL_SUPPORTFILESDIR=share/mysql           \
      -DMYSQL_DATADIR=/srv/mysql                      \
      -DMYSQL_UNIX_ADDR=/run/mysqld/mysqld.sock       \
      -DWITH_EXTRA_CHARSETS=complex                   \
      -DWITH_EMBEDDED_SERVER=ON                       \
      -DSKIP_TESTS=ON                                 \
      -DTOKUDB_OK=0                                   \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&

install -v -dm 755 /etc/mysql &&
sudo cat > /etc/mysql/my.cnf << "EOF" &&
# Begin /etc/mysql/my.cnf

# The following options will be passed to all MySQL clients
[client]
#password       = your_password
port            = 3306
socket          = /run/mysqld/mysqld.sock

# The MySQL server
[mysqld]
port            = 3306
socket          = /run/mysqld/mysqld.sock
datadir         = /srv/mysql
skip-external-locking
key_buffer_size = 16M
max_allowed_packet = 1M
sort_buffer_size = 512K
net_buffer_length = 16K
myisam_sort_buffer_size = 8M

# Don't listen on a TCP/IP port at all.
skip-networking

# required unique id between 1 and 2^32 - 1
server-id       = 1

# Uncomment the following if you are using BDB tables
#bdb_cache_size = 4M
#bdb_max_lock = 10000

# InnoDB tables are now used by default
innodb_data_home_dir = /srv/mysql
innodb_log_group_home_dir = /srv/mysql
# All the innodb_xxx values below are the default ones:
innodb_data_file_path = ibdata1:12M:autoextend
# You can set .._buffer_pool_size up to 50 - 80 %
# of RAM but beware of setting memory usage too high
innodb_buffer_pool_size = 128M
innodb_log_file_size = 48M
innodb_log_buffer_size = 16M
innodb_flush_log_at_trx_commit = 1
innodb_lock_wait_timeout = 50

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash
# Remove the next comment character if you are not familiar with SQL
#safe-updates

[isamchk]
key_buffer = 20M
sort_buffer_size = 20M
read_buffer = 2M
write_buffer = 2M

[myisamchk]
key_buffer_size = 20M
sort_buffer_size = 20M
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout

# End /etc/mysql/my.cnf
EOF

mysql_install_db --basedir=/usr --datadir=/srv/mysql --user=mysql &&
chown -R mysql:mysql /srv/mysql &&

mysqladmin -u root password &&
mysqladmin -p shutdown &&

cd blfs-systemd-units &&
as_root make install-mysqld &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
