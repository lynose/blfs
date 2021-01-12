#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/sqlite-autoconf-3340000
 then
  rm -rf /sources/sqlite-autoconf-3340000
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://sqlite.org/2020/sqlite-autoconf-3340000.tar.gz \
    /sources &&
    
check_and_download https://sqlite.org/2020/sqlite-doc-3340000.zip \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-sqlite &&

tar xf /sources/sqlite-autoconf-3340000.tar.gz -C /sources/ &&

cd /sources/sqlite-autoconf-3340000 &&

unzip -q ../sqlite-doc-3340000.zip &&

./configure --prefix=/usr     \
            --disable-static  \
            --enable-fts5     \
            CFLAGS="-g -O2                    \
            -DSQLITE_ENABLE_FTS3=1            \
            -DSQLITE_ENABLE_FTS4=1            \
            -DSQLITE_ENABLE_COLUMN_METADATA=1 \
            -DSQLITE_ENABLE_UNLOCK_NOTIFY=1   \
            -DSQLITE_ENABLE_DBSTAT_VTAB=1     \
            -DSQLITE_SECURE_DELETE=1          \
            -DSQLITE_ENABLE_FTS3_TOKENIZER=1" &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
as_root install -v -m755 -d /usr/share/doc/sqlite-3.34.0 &&
as_root cp -v -R sqlite-doc-3340000/* /usr/share/doc/sqlite-3.34.0 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
