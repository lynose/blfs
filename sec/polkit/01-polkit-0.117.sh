#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/polkit-0.117
 then
  rm -rf /sources/polkit-0.117
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://www.freedesktop.org/software/polkit/releases/polkit-0.117.tar.gz \
    --continue --directory-prefix=/sources &&
wget https://gitlab.freedesktop.org/polkit/polkit/-/raw/0.117/test/polkitbackend/polkitbackendjsauthoritytest-wrapper.py \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-polkit &&

tar xf /sources/polkit-0.117.tar.gz -C /sources/ &&

cd /sources/polkit-0.117 &&

groupadd -fg 27 polkitd &&
useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 27 \
        -g polkitd -s /bin/false polkitd &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static     \
            --with-os-type=LFS   &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
