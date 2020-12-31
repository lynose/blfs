#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/polkit-0.117
 then
  rm -rf /sources/polkit-0.117
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.freedesktop.org/software/polkit/releases/polkit-0.117.tar.gz \
    /sources &&
check_and_download https://gitlab.freedesktop.org/polkit/polkit/-/raw/0.117/test/polkitbackend/polkitbackendjsauthoritytest-wrapper.py \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-polkit &&

tar xf /sources/polkit-0.117.tar.gz -C /sources/ &&

cd /sources/polkit-0.117 &&

as_root_groupadd groupadd -fg 27 polkitd &&
as_root_useradd useradd -c \"PolicyKit_Daemon_Owner\" -d /etc/polkit-1 -u 27 \
        -g polkitd -s /bin/false polkitd &&

./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static     \
            --with-os-type=LFS   &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
