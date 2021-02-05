#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/pygtk-2.24.0
 then
  rm -rf /sources/pygtk-2.24.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/pygtk/2.24/pygtk-2.24.0.tar.bz2 \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-pygtk &&

tar xf /sources/pygtk-2.24.0.tar.bz2 -C /sources/ &&

cd /sources/pygtk-2.24.0 &&

as_root ln -svf /usr/bin/python2 /usr/bin/python &&
sed -i '1394,1402 d' pango.defs &&

./configure --prefix=/usr &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root ln -svf /usr/bin/python3 /usr/bin/python &&
as_root python3 -m pip install --force pip &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
