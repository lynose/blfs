#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/sqlite-autoconf-3360000
 then
  as_root rm -rf /sources/sqlite-autoconf-3360000
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://sqlite.org/2021/sqlite-autoconf-3360000.tar.gz \
    /sources &&
    
check_and_download https://sqlite.org/2021/sqlite-doc-3360000.zip \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-sqlite &&

tar xf /sources/sqlite-autoconf-3360000.tar.gz -C /sources/ &&

cd /sources/sqlite-autoconf-3360000 &&

unzip -q ../sqlite-doc-3360000.zip &&

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
as_root install -v -m755 -d /usr/share/doc/sqlite-3.36.0 &&
as_root cp -v -R sqlite-doc-3360000/* /usr/share/doc/sqlite-3.36.0 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
