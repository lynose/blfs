#!/bin/bash

${log} `basename "$0"` " started" devtools &&
if test -d /sources/cbindgen-0.14.2
 then
  rm -rf /sources/cbindgen-0.14.2
fi

tar -xzf /sources/cbindgen-0.14.2.tar.gz -C /sources/ &&

cd /sources/cbindgen-0.14.2 &&

cargo build --release
${log} `basename "$0"` " built" devtools &&

as_root install -Dm755 target/release/cbindgen /usr/bin/
${log} `basename "$0"` " installed" devtools &&

${log} `basename "$0"` " finished" devtools 
