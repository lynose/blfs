#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/Jinja2-2.11.2
 then
  rm -rf /sources/Jinja2-2.11.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://files.pythonhosted.org/packages/source/J/Jinja2/Jinja2-2.11.2.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-Jinja2 &&

tar xf /sources/Jinja2-2.11.2.tar.gz -C /sources/ &&

cd /sources/Jinja2-2.11.2 &&

python3 setup.py install --optimize=1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
