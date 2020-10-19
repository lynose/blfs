#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/krb5-1.18.2
 then
  rm -rf /sources/krb5-1.18.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://kerberos.org/dist/krb5/1.18/krb5-1.18.2.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-krb5 &&

tar xf /sources/krb5-1.18.2.tar.gz -C /sources/ &&

cd /sources/krb5-1.18.2 &&

cd src &&
 
sed -i -e 's@\^u}@^u cols 300}@' tests/dejagnu/config/default.exp     &&
sed -i -e '/eq 0/{N;s/12 //}'    plugins/kdb/db2/libdb2/test/run.test &&

./configure --prefix=/usr            \
            --sysconfdir=/etc        \
            --localstatedir=/var/lib \
            --with-system-et         \
            --with-system-ss         \
            --with-system-verto=no   \
            --enable-dns-for-realm &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install &&

for f in gssapi_krb5 gssrpc k5crypto kadm5clnt kadm5srv \
         kdb5 kdb_ldap krad krb5 krb5support verto ; do

    find /usr/lib -type f -name "lib$f*.so*" -exec chmod -v 755 {} \;    
done          &&

mv -v /usr/lib/libkrb5.so.3*        /lib &&
mv -v /usr/lib/libk5crypto.so.3*    /lib &&
mv -v /usr/lib/libkrb5support.so.0* /lib &&

ln -v -sf ../../lib/libkrb5.so.3.3        /usr/lib/libkrb5.so        &&
ln -v -sf ../../lib/libk5crypto.so.3.1    /usr/lib/libk5crypto.so    &&
ln -v -sf ../../lib/libkrb5support.so.0.1 /usr/lib/libkrb5support.so &&

mv -v /usr/bin/ksu /bin &&
chmod -v 755 /bin/ksu   &&

install -v -dm755 /usr/share/doc/krb5-1.18.2 &&
cp -vfr ../doc/*  /usr/share/doc/krb5-1.18.2 &&

${log} `basename "$0"` " installed" blfs_all &&

make -k -j1 check &&
${log} `basename "$0"` " unexpected check succeed" blfs_all
${log} `basename "$0"` " expected check fail?" blfs_all &&

${log} `basename "$0"` " finished" blfs_all 
