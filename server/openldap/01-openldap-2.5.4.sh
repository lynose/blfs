#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/openldap-2.5.4
 then
  rm -rf /sources/openldap-2.5.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.5.4.tgz \
        /sources

check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/openldap-2.5.4-consolidated-1.patch \
        /sources        

md5sum -c ${SCRIPTPATH}/md5-openldap &&

tar xf /sources/openldap-2.5.4.tgz -C /sources/ &&

cd /sources/openldap-2.5.4 &&

as_root_groupadd groupadd -g 83 ldap &&
as_root_useradd useradd  -c  \"OpenLDAP_Daemon_Owner\" -d /var/lib/openldap -u 83 -g ldap -s /bin/false ldap &&

patch -Np1 -i ../openldap-2.5.4-consolidated-1.patch &&
autoconf &&

./configure --prefix=/usr         \
            --sysconfdir=/etc     \
            --localstatedir=/var  \
            --libexecdir=/usr/lib \
            --disable-static      \
            --disable-debug       \
            --with-tls=openssl    \
            --with-cyrus-sasl     \
            --enable-dynamic      \
            --enable-crypt        \
            --enable-spasswd      \
            --enable-slapd        \
            --enable-modules      \
            --enable-rlookups     \
            --enable-backends=mod \
            --disable-ndb         \
            --disable-wt          \
#             --disable-shell       \
#             --disable-bdb         \
#             --disable-hdb         \
            --enable-overlays=mod  &&

make depend &&            
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&

as_root sed -e "s/\.la/.so/" -i /etc/openldap/slapd.{conf,ldif}{,.default} &&

as_root install -v -dm700 -o ldap -g ldap /var/lib/openldap     &&

as_root install -v -dm700 -o ldap -g ldap /etc/openldap/slapd.d &&
as_root chmod   -v    640     /etc/openldap/slapd.{conf,ldif}   &&
as_root chown   -v  root:ldap /etc/openldap/slapd.{conf,ldif}   &&

as_root install -v -dm755 /usr/share/doc/openldap-2.5.4 &&
as_root cp      -vfr      doc/{drafts,rfc,guide} \
                  /usr/share/doc/openldap-2.5.4 &&
                  
cd /usr/src/blfs-systemd-units &&
as_root make install-slapd &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
