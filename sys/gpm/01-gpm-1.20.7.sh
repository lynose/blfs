#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gpm-1.20.7
 then
  rm -rf /sources/gpm-1.20.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://anduin.linuxfromscratch.org/BLFS/gpm/gpm-1.20.7.tar.bz2 \
    /sources &&

check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/gpm-1.20.7-consolidated-1.patch \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-gpm &&

tar xf /sources/gpm-1.20.7.tar.bz2 -C /sources/ &&

cd /sources/gpm-1.20.7 &&

patch -Np1 -i ../gpm-1.20.7-consolidated-1.patch &&
./autogen.sh                                     &&
./configure --prefix=/usr --sysconfdir=/etc &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install                                          &&

as_root install-info --dir-file=/usr/share/info/dir           \
             /usr/share/info/gpm.info                 &&

as_root ln -sfv libgpm.so.2.1.0 /usr/lib/libgpm.so            &&
as_root install -v -m644 conf/gpm-root.conf /etc              &&

as_root install -v -m755 -d /usr/share/doc/gpm-1.20.7/support &&
as_root install -v -m644    doc/support/*                     \
                    /usr/share/doc/gpm-1.20.7/support &&
as_root install -v -m644    doc/{FAQ,HACK_GPM,README*}        \
                    /usr/share/doc/gpm-1.20.7 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
