#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/docbook-xml-4.5
 then
  rm -rf /sources/docbook-xml-4.5
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.docbook.org/xml/4.5/docbook-xml-4.5.zip \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-docbook-xml &&

mkdir /sources/docbook-xml-4.5 &&
cd /sources/docbook-xml-4.5 &&
unzip ../docbook-xml-4.5.zip &&

as_root install -v -d -m755 /usr/share/xml/docbook/xml-dtd-4.5 &&
as_root install -v -d -m755 /etc/xml &&
as_root chown -R root:root . &&
as_root cp -v -af docbook.cat *.dtd ent/ *.mod \
    /usr/share/xml/docbook/xml-dtd-4.5 &&
    
as_root $SCRIPTPATH/docbook-xml-4.5-cat-inst.sh &&
    
    
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
