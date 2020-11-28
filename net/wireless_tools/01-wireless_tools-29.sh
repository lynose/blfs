#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/wireless_tools.29
 then
  rm -rf /sources/wireless_tools.29
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://hewlettpackard.github.io/wireless-tools/wireless_tools.29.tar.gz \
        /sources
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/wireless_tools-29-fix_iwlist_scanning-1.patch \
        /sources


md5sum -c ${SCRIPTPATH}/md5-wireless_tools &&

tar xf /sources/wireless_tools.29.tar.gz -C /sources/ &&

cd /sources/wireless_tools.29 &&

patch -Np1 -i ../wireless_tools-29-fix_iwlist_scanning-1.patch &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make PREFIX=/usr INSTALL_MAN=/usr/share/man install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
