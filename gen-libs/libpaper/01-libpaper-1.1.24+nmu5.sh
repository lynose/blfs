#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libpaper-1.1.24+nmu5
 then
  rm -rf /sources/libpaper-1.1.24+nmu5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.debian.org/debian/pool/main/libp/libpaper/libpaper_1.1.24+nmu5.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-libpaper &&

tar xf /sources/libpaper_1.1.24+nmu5.tar.gz -C /sources/ &&

cd /sources/libpaper-1.1.24+nmu5 &&

autoreconf -fi                &&
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&


as_root make install &&
mkdir -vp /etc/libpaper.d &&
as_root cat > /etc/papersize << "EOF"
a4
EOF
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
