#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/LSB-Tools-0.7
 then
  rm -rf /sources/LSB-Tools-0.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/djlucas/LSB-Tools/releases/download/v0.7/LSB-Tools-0.7.tar.gz \
    --continue --directory-prefix=/sources &&

md5sum -c ${SCRIPTPATH}/md5-LSB-Tools &&

tar xf /sources/LSB-Tools-0.7.tar.gz -C /sources/ &&

cd /sources/LSB-Tools-0.7 &&

python3 setup.py build &&
${log} `basename "$0"` " built" blfs_all &&

python3 setup.py install --optimize=1 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
