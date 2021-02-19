#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lightdm-1.30.0
 then
  as_root rm -rf /sources/lightdm-1.30.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/CanonicalLtd/lightdm/releases/download/1.30.0/lightdm-1.30.0.tar.xz \
        /sources &&
check_and_download https://github.com/Xubuntu/lightdm-gtk-greeter/releases/download/lightdm-gtk-greeter-2.0.8/lightdm-gtk-greeter-2.0.8.tar.gz \
        /sources &&

md5sum -c ${SCRIPTPATH}/md5-lightdm &&

tar xf /sources/lightdm-1.30.0.tar.xz -C /sources/ &&

cd /sources/lightdm-1.30.0 &&

as_root_groupadd groupadd -g 65 lightdm       &&
as_root_useradd useradd  -c "Lightdm_Daemon" \
         -d /var/lib/lightdm \
         -u 65 -g lightdm    \
         -s /bin/false lightdm &&

./configure                          \
       --prefix=/usr                 \
       --libexecdir=/usr/lib/lightdm \
       --localstatedir=/var          \
       --sbindir=/usr/bin            \
       --sysconfdir=/etc             \
       --disable-static              \
       --disable-tests               \
       --with-greeter-user=lightdm   \
       --with-greeter-session=lightdm-gtk-greeter \
       --docdir=/usr/share/doc/lightdm-1.30.0 &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install                                                  &&
as_root cp tests/src/lightdm-session /usr/bin                         &&

cp /usr/bin/lightdm-session /tmp &&
sed -i '1 s/sh/bash --login/' /tmp/lightdm-session        &&
as_root mv /tmp/lightdm-session /usr/bin/lightdm-session &&
as_root rm -rf /etc/init                                              &&
as_root install -v -dm755 -o lightdm -g lightdm /var/lib/lightdm      &&
as_root install -v -dm755 -o lightdm -g lightdm /var/lib/lightdm-data &&
as_root install -v -dm755 -o lightdm -g lightdm /var/cache/lightdm    &&
as_root install -v -dm770 -o lightdm -g lightdm /var/log/lightdm &&
${log} `basename "$0"` " installed" blfs_all &&
tar -xf ../lightdm-gtk-greeter-2.0.8.tar.gz &&
cd lightdm-gtk-greeter-2.0.8 &&

./configure                      \
   --prefix=/usr                 \
   --libexecdir=/usr/lib/lightdm \
   --sbindir=/usr/bin            \
   --sysconfdir=/etc             \
   --with-libxklavier            \
   --enable-kill-on-sigterm      \
   --disable-libido              \
   --disable-libindicator        \
   --disable-static              \
   --disable-maintainer-mode     \
   --docdir=/usr/share/doc/lightdm-gtk-greeter-2.0.8 &&
${log} `basename "$0"` " configured greeter" blfs_all &&

make &&
${log} `basename "$0"` " built greeter" blfs_all &&

as_root make install &&
cd /usr/src/blfs-systemd-units &&
as_root make install-lightdm &&
as_root systemctl enable lightdm &&
${log} `basename "$0"` " installed greeter" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
