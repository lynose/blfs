#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xfsprogs-5.11.0
 then
  rm -rf /sources/xfsprogs-5.11.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/xfsprogs-5.11.0.tar.xz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xfsprogs &&

tar xf /sources/xfsprogs-5.11.0.tar.xz -C /sources/ &&

cd /sources/xfsprogs-5.11.0 &&

make DEBUG=-DNDEBUG     \
     INSTALL_USER=root  \
     INSTALL_GROUP=root &&
${log} `basename "$0"` " built" blfs_all &&

as_root make PKG_DOC_DIR=/usr/share/doc/xfsprogs-5.11.0 install     &&
as_root make PKG_DOC_DIR=/usr/share/doc/xfsprogs-5.11.0 install-dev &&

as_root rm -rfv /usr/lib/libhandle.a                                &&
as_root rm -rfv /lib/libhandle.{a,la,so}                            &&
as_root ln -sfv ../../lib/libhandle.so.1 /usr/lib/libhandle.so &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
