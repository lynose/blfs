#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/MarkupSafe-2.0.1
 then
  rm -rf /sources/MarkupSafe-2.0.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://files.pythonhosted.org/packages/source/M/MarkupSafe/MarkupSafe-2.0.1.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-MarkupSafe &&

tar xf /sources/MarkupSafe-2.0.1.tar.gz -C /sources/ &&

cd /sources/MarkupSafe-2.0.1 &&

python3 setup.py build &&
${log} `basename "$0"` " built" blfs_all &&

as_root python3 setup.py install --optimize=1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 