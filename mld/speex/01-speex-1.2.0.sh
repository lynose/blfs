#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/speex-1.2.0
 then
  rm -rf /sources/speex-1.2.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://downloads.xiph.org/releases/speex/speex-1.2.0.tar.gz \
    --continue --directory-prefix=/sources &&
wget https://downloads.xiph.org/releases/speex/speexdsp-1.2.0.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-speex &&

tar xf /sources/speex-1.2.0.tar.gz -C /sources/ &&

cd /sources/speex-1.2.0 &&

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/speex-1.2.0 &&
${log} `basename "$0"` " configured speex" blfs_all &&

make &&
${log} `basename "$0"` " built speex" blfs_all &&

make install &&
${log} `basename "$0"` " installed speex" blfs_all &&

cd ..                          &&
tar -xf speexdsp-1.2.0.tar.gz &&
cd speexdsp-1.2.0             &&

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/speexdsp-1.2.0 &&
${log} `basename "$0"` " configured speexdsp" blfs_all &&
make &&
${log} `basename "$0"` " built speexdsp" blfs_all &&
make install &&
${log} `basename "$0"` " installed speexdsp" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
