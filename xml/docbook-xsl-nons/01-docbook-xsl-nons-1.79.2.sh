#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/docbook-xsl-nons-1.79.2
 then
  rm -rf /sources/docbook-xsl-nons-1.79.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/docbook/xslt10-stylesheets/releases/download/release/1.79.2/docbook-xsl-nons-1.79.2.tar.bz2 \
    /sources &&

check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/docbook-xsl-nons-1.79.2-stack_fix-1.patch \
    /sources &&

check_and_download https://github.com/docbook/xslt10-stylesheets/releases/download/release/1.79.2/docbook-xsl-doc-1.79.2.tar.bz2 \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-docbook-xsl-nons &&

tar xf /sources/docbook-xsl-nons-1.79.2.tar.bz2 -C /sources/ &&

cd /sources/docbook-xsl-nons-1.79.2 &&

patch -Np1 -i ../docbook-xsl-nons-1.79.2-stack_fix-1.patch &&

tar -xf ../docbook-xsl-doc-1.79.2.tar.bz2 --strip-components=1 &&

as_root install -v -m755 -d /usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2 &&

as_root cp -v -R VERSION assembly common eclipse epub epub3 extensions fo        \
         highlighting html htmlhelp images javahelp lib manpages params  \
         profiling roundtrip slides template tests tools webhelp website \
         xhtml xhtml-1_1 xhtml5                                          \
    /usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2 &&

as_root ln -sf VERSION /usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2/VERSION.xsl &&

as_root install -v -m644 -D README \
                    /usr/share/doc/docbook-xsl-nons-1.79.2/README.txt &&
as_root install -v -m644    RELEASE-NOTES* NEWS* \
                    /usr/share/doc/docbook-xsl-nons-1.79.2 &&
as_root cp -v -R doc/* /usr/share/doc/docbook-xsl-nons-1.79.2 &&
${log} `basename "$0"` " install stylesheets" blfs_all &&

if [ ! -d /etc/xml ]; then as_root install -v -m755 -d /etc/xml; fi &&
if [ ! -f /etc/xml/catalog ]; then
    as_root xmlcatalog --noout --create /etc/xml/catalog
fi &&

as_root xmlcatalog --noout --add "rewriteSystem" \
           "https://cdn.docbook.org/release/xsl-nons/1.79.2" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
    /etc/xml/catalog &&

as_root xmlcatalog --noout --add "rewriteURI" \
           "https://cdn.docbook.org/release/xsl-nons/1.79.2" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
    /etc/xml/catalog &&

as_root xmlcatalog --noout --add "rewriteSystem" \
           "https://cdn.docbook.org/release/xsl-nons/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
    /etc/xml/catalog &&

as_root xmlcatalog --noout --add "rewriteURI" \
           "https://cdn.docbook.org/release/xsl-nons/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
    /etc/xml/catalog &&

as_root xmlcatalog --noout --add "rewriteSystem" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
    /etc/xml/catalog &&

as_root xmlcatalog --noout --add "rewriteURI" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-1.79.2" \
    /etc/xml/catalog &&
${log} `basename "$0"` " create xmlcatalog" blfs_all &&

as_root xmlcatalog --noout --add "rewriteSystem" \
           "http://docbook.sourceforge.net/release/xsl/1.79.2" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.79.2" \
    /etc/xml/catalog &&

as_root xmlcatalog --noout --add "rewriteURI" \
           "http://docbook.sourceforge.net/release/xsl/1.79.2" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.79.2" \
    /etc/xml/catalog &&
${log} `basename "$0"` " substitude LFS version" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
