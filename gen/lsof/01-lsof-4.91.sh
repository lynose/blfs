#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lsof_4.91
 then
  rm -rf /sources/lsof_4.91
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.mirrorservice.org/sites/lsof.itap.purdue.edu/pub/tools/unix/lsof/lsof_4.91.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-lsof &&

tar xf /sources/lsof_4.91.tar.gz -C /sources/ &&

cd /sources/lsof_4.91 &&

tar -xf lsof_4.91_src.tar  &&
cd lsof_4.91_src           &&
./Configure -n linux       &&
${log} `basename "$0"` " configured" blfs_all &&

make CFGL="-L./lib -ltirpc" &&
${log} `basename "$0"` " built" blfs_all &&

as_root install -v -m0755 -o root -g root lsof /usr/bin &&
as_root install -v lsof.8 /usr/share/man/man8 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
