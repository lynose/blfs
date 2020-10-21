#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/install-tl-20201020
 then
  rm -rf /sources/install-tl-20201020
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    --continue --directory-prefix=/sources &&

tar xf /sources/install-tl-unx.tar.gz -C /sources/ &&

cd /sources/install-tl-20201020 &&

TEXLIVE_INSTALL_PREFIX=/opt/texlive ./install-tl &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
