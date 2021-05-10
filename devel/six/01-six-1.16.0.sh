#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/six-1.16.0
 then
  rm -rf /sources/six-1.16.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://files.pythonhosted.org/packages/source/s/six/six-1.16.0.tar.gz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-six &&

tar xf /sources/six-1.16.0.tar.gz -C /sources/ &&

cd /sources/six-1.16.0 &&


python2 setup.py build &&
python3 setup.py build &&
${log} `basename "$0"` " built" blfs_all &&

as_root python2 setup.py install --optimize=1 &&
as_root python3 setup.py install --optimize=1 &&

as_root ln -svf /usr/bin/python3 /usr/bin/python &&
as_root python3 -m pip install --force pip &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
