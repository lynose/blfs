#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/docbook-4.5
 then
  rm -rf /sources/docbook-4.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://www.docbook.org/sgml/4.5/docbook-4.5.zip \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-docbook-dtd &&

mkdir /sources/docbook-4.5 &&
cd /sources/docbook-4.5 &&
unzip /sources/docbook-4.5.zip &&



sed -i -e '/ISO 8879/d' \
       -e '/gml/d' docbook.cat &&
${log} `basename "$0"` " configured" blfs_all &&

install -v -d /usr/share/sgml/docbook/sgml-dtd-4.5 &&
chown -R root:root . &&

install -v docbook.cat /usr/share/sgml/docbook/sgml-dtd-4.5/catalog &&
cp -v -af *.dtd *.mod *.dcl /usr/share/sgml/docbook/sgml-dtd-4.5 &&

install-catalog --add /etc/sgml/sgml-docbook-dtd-4.5.cat \
    /usr/share/sgml/docbook/sgml-dtd-4.5/catalog &&

install-catalog --add /etc/sgml/sgml-docbook-dtd-4.5.cat \
    /etc/sgml/sgml-docbook.cat &&
${log} `basename "$0"` " install catalog" blfs_all &&


${log} `basename "$0"` " finished" blfs_all 
