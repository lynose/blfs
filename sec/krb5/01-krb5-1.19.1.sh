#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/krb5-1.19.1
 then
  rm -rf /sources/krb5-1.19.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://kerberos.org/dist/krb5/1.19/krb5-1.19.1.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-krb5 &&

tar xf /sources/krb5-1.19.1.tar.gz -C /sources/ &&

cd /sources/krb5-1.19.1 &&

cd src &&
 

sed -i -e 's@\^u}@^u cols 300}@' tests/dejagnu/config/default.exp     &&
sed -i -e '/eq 0/{N;s/12 //}'    plugins/kdb/db2/libdb2/test/run.test &&
sed -i '/t_iprop.py/d'           tests/Makefile.in                    &&

./configure --prefix=/usr            \
            --sysconfdir=/etc        \
            --localstatedir=/var/lib \
            --runstatedir=/run       \
            --with-system-et         \
            --with-system-ss         \
            --with-system-verto=no   \
            --enable-dns-for-realm &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&

as_root install -v -dm755 /usr/share/doc/krb5-1.19.1 &&
as_root cp -vfr ../doc/*  /usr/share/doc/krb5-1.19.1 &&

${log} `basename "$0"` " installed" blfs_all &&
if [ ${ENABLE_TEST} == true ]
 then
    make -k -j1 check &&
    ${log} `basename "$0"` " check succeed" blfs_all ||
    ${log} `basename "$0"` " check fail?" blfs_all
fi 
${log} `basename "$0"` " finished" blfs_all 
