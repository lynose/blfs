#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Jinja2-2.11.3
 then
  as_root rm -rf /sources/Jinja2-2.11.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://files.pythonhosted.org/packages/source/J/Jinja2/Jinja2-2.11.3.tar.gz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-Jinja2 &&

tar xf /sources/Jinja2-2.11.3.tar.gz -C /sources/ &&

cd /sources/Jinja2-2.11.3 &&

as_root python3 setup.py install --optimize=1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
