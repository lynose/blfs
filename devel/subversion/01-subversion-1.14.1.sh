#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/subversion-1.14.1
 then
  rm -rf /sources/subversion-1.14.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://archive.apache.org/dist/subversion/subversion-1.14.1.tar.bz2 \
        /sources


md5sum -c ${SCRIPTPATH}/md5-subversion &&

tar xf /sources/subversion-1.14.1.tar.bz2 -C /sources &&

cd /sources/subversion-1.14.1 &&

PYTHON=python3 ./configure --prefix=/usr             \
            --disable-static          \
            --with-apache-libexecdir  \
            --with-lz4=internal       \
            --with-utf8proc=internal  \
            --enable-javahl &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
doxygen doc/doxygen.conf &&
make javahl &&
make swig-pl && # for Perl
# make swig-py \
#      swig_pydir=/usr/lib/python3.9/site-packages/libsvn \
#      swig_pydir_extra=/usr/lib/python3.9/site-packages/svn && # for Python
make swig-rb && # for Ruby 
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
  LANG=C make check-javahl &&
    ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
  make check-swig-pl &&
  ${log} `basename "$0"` " unexpected check-swig-pl succeed" blfs_all
  ${log} `basename "$0"` " expected check-swig-pl fail?" blfs_all
#   make check-swig-py &&
#   ${log} `basename "$0"` " unexpected check-swig-py succeed" blfs_all
#   ${log} `basename "$0"` " expected check-swig-py fail?" blfs_all
  make check-swig-rb &&
  ${log} `basename "$0"` " unexpected check-swig-rb succeed" blfs_all
  ${log} `basename "$0"` " expected check-swig-rb fail?" blfs_all
fi

as_root make install &&
as_root install -v -m755 -d /usr/share/doc/subversion-1.14.1 &&
as_root cp      -v -R doc/* /usr/share/doc/subversion-1.14.1 &&
as_root make install-javahl
as_root make install-swig-pl &&
# as_root make install-swig-py \
#       swig_pydir=/usr/lib/python3.9/site-packages/libsvn \
#       swig_pydir_extra=/usr/lib/python3.9/site-packages/svn &&
as_root make install-swig-rb &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
