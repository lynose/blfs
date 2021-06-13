#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pycairo-1.20.1
 then
  rm -rf /sources/pycairo-1.20.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/pygobject/pycairo/releases/download/v1.20.1/pycairo-1.20.1.tar.gz \
    /sources &&

md5sum -c --ignore-missing ${SCRIPTPATH}/md5-pycairo &&

tar xf /sources/pycairo-1.20.1.tar.gz -C /sources/ &&

cd /sources/pycairo-1.20.1 &&

python3 setup.py build &&
${log} `basename "$0"` " built" blfs_all &&

as_root python3 setup.py install --optimize=1   &&
as_root python3 setup.py install_pycairo_header &&
as_root python3 setup.py install_pkgconfig &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
