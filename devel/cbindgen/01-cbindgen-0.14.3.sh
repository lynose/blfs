#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cbindgen-0.14.3
 then
  rm -rf /sources/cbindgen-0.14.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/eqrion/cbindgen/archive/v0.14.3/cbindgen-0.14.3.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-cbindgen &&

tar xf /sources/cbindgen-0.14.3.tar.gz -C /sources/ &&

cd /sources/cbindgen-0.14.3 &&

cargo build --release &&
${log} `basename "$0"` " built" blfs_all &&

cargo test &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

install -Dm755 target/release/cbindgen /usr/bin/ &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
