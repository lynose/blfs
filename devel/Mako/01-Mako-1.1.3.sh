#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Mako-1.1.3
 then
  rm -rf /sources/Mako-1.1.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://files.pythonhosted.org/packages/source/M/Mako/Mako-1.1.3.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-Mako &&

tar xf /sources/Mako-1.1.3.tar.gz -C /sources/ &&

cd /sources/Mako-1.1.3 &&

python3 setup.py install --optimize=1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
