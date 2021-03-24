#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/install-tl-20210308
 then
  rm -rf /sources/install-tl-20210308
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    /sources &&

tar xf /sources/install-tl-unx.tar.gz -C /sources/ &&

cd /sources/install-tl-20210131 &&

as_root TEXLIVE_INSTALL_PREFIX=/opt/texlive ./install-tl &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
