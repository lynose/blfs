#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/db-5.3.28
 then
  rm -rf /sources/db-5.3.28
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://anduin.linuxfromscratch.org/BLFS/bdb/db-5.3.28.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-db &&

tar xf /sources/db-5.3.28.tar.gz -C /sources/ &&

cd /sources/db-5.3.28 &&

sed -i 's/\(__atomic_compare_exchange\)/\1_db/' src/dbinc/atomic.h &&

cd build_unix                        &&
../dist/configure --prefix=/usr      \
                  --enable-compat185 \
                  --enable-dbm       \
                  --disable-static   \
                  --enable-cxx &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make docdir=/usr/share/doc/db-5.3.28 install &&

as_root chown -v -R root:root                        \
      /usr/bin/db_*                          \
      /usr/include/db{,_185,_cxx}.h          \
      /usr/lib/libdb*.{so,la}                \
      /usr/share/doc/db-5.3.28 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
