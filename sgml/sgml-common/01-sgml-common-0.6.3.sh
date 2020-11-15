#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/sgml-common-0.6.3
 then
  rm -rf /sources/sgml-common-0.6.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://sourceware.org/ftp/docbook-tools/new-trials/SOURCES/sgml-common-0.6.3.tgz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/sgml-common-0.6.3-manpage-1.patch \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-sgml-common &&

tar xf /sources/sgml-common-0.6.3.tgz -C /sources/ &&

cd /sources/sgml-common-0.6.3 &&

patch -Np1 -i ../sgml-common-0.6.3-manpage-1.patch &&
autoreconf -f -i &&
./configure --prefix=/usr --sysconfdir=/etc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make docdir=/usr/share/doc install &&

as_root install-catalog --add /etc/sgml/sgml-ent.cat \
    /usr/share/sgml/sgml-iso-entities-8879.1986/catalog &&

as_root install-catalog --add /etc/sgml/sgml-docbook.cat \
    /etc/sgml/sgml-ent.cat &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
