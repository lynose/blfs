#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Mako-1.1.4
 then
  rm -rf /sources/Mako-1.1.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://files.pythonhosted.org/packages/source/M/Mako/Mako-1.1.4.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-Mako &&

tar xf /sources/Mako-1.1.4.tar.gz -C /sources/ &&

cd /sources/Mako-1.1.4 &&

as_root python3 setup.py install --optimize=1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
