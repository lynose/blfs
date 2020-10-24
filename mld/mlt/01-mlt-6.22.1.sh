#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/mlt-6.22.1
 then
  rm -rf /sources/mlt-6.22.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/mltframework/mlt/releases/download/v6.22.1/mlt-6.22.1.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-mlt &&

tar xf /sources/mlt-6.22.1.tar.gz -C /sources/ &&

cd /sources/mlt-6.22.1 &&

./configure --prefix=/usr     \
            --enable-gpl      \
            --enable-gpl3     \
            --enable-opengl   \
            --disable-gtk2  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
