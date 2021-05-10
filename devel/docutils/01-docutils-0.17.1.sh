#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/docutils-0.17.1
 then
  rm -rf /sources/docutils-0.17.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://downloads.sourceforge.net/docutils/docutils-0.17.1.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-docutils &&

tar xf /sources/docutils-0.17.1.tar.gz -C /sources/ &&

cd /sources/docutils-0.17.1 &&

python3 setup.py build &&
${log} `basename "$0"` " configured" blfs_all &&

as_root python3 setup.py install --optimize=1 &&

for f in /usr/bin/rst*.py; do
  as_root ln -svf $(basename $f) /usr/bin/$(basename $f .py)
done
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
