#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xf86-video-intel-20200817
 then
  rm -rf /sources/xf86-video-intel-20200817
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://anduin.linuxfromscratch.org/BLFS/xf86-video-intel/xf86-video-intel-20200817.tar.xz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-xf86-video-intel &&

tar xf /sources/xf86-video-intel-20200817.tar.xz -C /sources/ &&

cd /sources/xf86-video-intel-20200817 &&

./autogen.sh $XORG_CONFIG     \
            --enable-kms-only \
            --enable-uxa      \
            --mandir=/usr/share/man &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
      
mv -v /usr/share/man/man4/intel-virtual-output.4 \
      /usr/share/man/man1/intel-virtual-output.1 &&
      
sed -i '/\.TH/s/4/1/' /usr/share/man/man1/intel-virtual-output.1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
