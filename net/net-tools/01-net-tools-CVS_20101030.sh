#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/net-tools-CVS_20101030
 then
  rm -rf /sources/net-tools-CVS_20101030
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://anduin.linuxfromscratch.org/BLFS/net-tools/net-tools-CVS_20101030.tar.gz \
        /sources

check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/net-tools-CVS_20101030-remove_dups-1.patch \
        /sources

md5sum -c ${SCRIPTPATH}/md5-net-tools &&

tar xf /sources/net-tools-CVS_20101030.tar.gz -C /sources/ &&

cd /sources/net-tools-CVS_20101030 &&

patch -Np1 -i ../net-tools-CVS_20101030-remove_dups-1.patch &&
sed -i '/#include <netinet\/ip.h>/d'  iptunnel.c &&

yes "" | make config  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make update &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
