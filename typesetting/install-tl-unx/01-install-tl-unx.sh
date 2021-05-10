#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -f /sources/install-tl-unx.tar.gz
 then
  as_root rm -rf /sources/install-tl-unx.tar.gz
fi

as_root rm -rf /sources/install-tl-20*


SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    /sources &&

tar xf /sources/install-tl-unx.tar.gz -C /sources/ &&

TEXBASIC=`find /sources/ -type d -name "install-tl-20*"` &&

cd ${TEXBASIC} &&

as_root TEXLIVE_INSTALL_PREFIX=/opt/texlive ./install-tl &&
for F in /opt/texlive/2021/texmf-dist/scripts/latex-make/*.py ; do
  test -f $F && sed -i 's%/usr/bin/env python%/usr/bin/python3%' $F || true
done
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
