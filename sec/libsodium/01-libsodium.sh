#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
url=https://github.com/jedisct1/libsodium.git
version="1.0.18"

gitget $url \
        /sources \
        $version &&

pack=`basename ${url}`
packname=${pack:0: -4}
gitpack=/sources/git/${packname}

cd ${gitpack} &&


./autogen.sh &&
./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
