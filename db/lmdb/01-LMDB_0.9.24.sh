#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lmdb-LMDB_0.9.24
 then
  rm -rf /sources/lmdb-LMDB_0.9.24
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/LMDB/lmdb/archive/LMDB_0.9.24.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-LMDB &&

tar xf /sources/LMDB_0.9.24.tar.gz -C /sources/ &&

cd /sources/lmdb-LMDB_0.9.24 &&

cd libraries/liblmdb &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
sed -i 's| liblmdb.a||' Makefile &&
${log} `basename "$0"` " built" blfs_all &&

make prefix=/usr install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
