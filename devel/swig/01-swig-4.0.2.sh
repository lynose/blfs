#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/swig-4.0.2
 then
  rm -rf /sources/swig-4.0.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/swig-4.0.2.tar.gz ];  
 then
  check_and_download https://downloads.sourceforge.net/swig/swig-4.0.2.tar.gz \
    /sources
fi

md5sum -c ${SCRIPTPATH}/md5-swig &&

tar xf /sources/swig-4.0.2.tar.gz -C /sources/ &&

cd /sources/swig-4.0.2 &&

./configure --prefix=/usr \
            --without-maximum-compile-warnings &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&



if [ ${ENABLE_TEST} == true ]
 then
  PY3=1 make -k check TCL_INCLUDE=. &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi


as_root make install &&
as_root install -v -m755 -d /usr/share/doc/swig-4.0.2 &&
as_root cp -v -R Doc/* /usr/share/doc/swig-4.0.2 &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
