#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/postgresql-13.1
 then
  rm -rf /sources/postgresql-13.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.postgresql.org/pub/source/v13.1/postgresql-13.1.tar.bz2 \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-postgresql &&

tar xf /sources/postgresql-13.1.tar.bz2 -C /sources/ &&

cd /sources/postgresql-13.1 &&

as_root_groupadd groupadd -g 41 postgres &&
as_root_useradd useradd -c "PostgreSQL_Server" -g postgres -d /srv/pgsql/data \
        -u 41 postgres &&


sed -i '/DEFAULT_PGSOCKET_DIR/s@/tmp@/run/postgresql@' src/include/pg_config_manual.h &&

./configure --prefix=/usr          \
            --enable-thread-safety \
            --docdir=/usr/share/doc/postgresql-13.1 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
make -C contrib &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true && UID != 0 ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root make install-docs &&
as_root make -C contrib install &&
as_root install -v -dm700 /srv/pgsql/data &&
as_root install -v -dm755 /run/postgresql &&
as_root chown -Rv postgres:postgres /srv/pgsql /run/postgresql &&
cd /usr/src/blfs-systemd-units &&
as_root make install-postgresql &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
