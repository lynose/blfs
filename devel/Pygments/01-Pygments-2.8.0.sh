#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Pygments-2.8.0
 then
  rm -rf /sources/Pygments-2.8.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://files.pythonhosted.org/packages/source/P/Pygments/Pygments-2.8.0.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-Pygments &&

tar xf /sources/Pygments-2.8.0.tar.gz -C /sources/ &&

cd /sources/Pygments-2.8.0 &&

as_root python3 setup.py install --optimize=1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
