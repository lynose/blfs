#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/libxml2-2.9.10
 then
  rm -rf /sources/libxml2-2.9.10
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://xmlsoft.org/sources/libxml2-2.9.10.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-python-libxml2 &&

tar xf /sources/libxml2-2.9.10.tar.gz -C /sources/ &&

cd /sources/libxml2-2.9.10 &&

cd python             &&
${log} `basename "$0"` " configured" blfs_all &&

python2 setup.py build &&
${log} `basename "$0"` " built" blfs_all &&

as_root python2 setup.py install --optimize=1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
