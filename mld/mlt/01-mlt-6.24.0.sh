#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mlt-6.24.0
 then
  rm -rf /sources/mlt-6.24.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/mltframework/mlt/releases/download/v6.24.0/mlt-6.24.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-mlt &&

tar xf /sources/mlt-6.24.0.tar.gz -C /sources/ &&

cd /sources/mlt-6.24.0 &&

./configure --prefix=/usr     \
            --enable-gpl      \
            --enable-gpl3     \
            --enable-opengl   \
            --disable-gtk2  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
