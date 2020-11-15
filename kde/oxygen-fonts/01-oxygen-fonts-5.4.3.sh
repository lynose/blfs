#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/oxygen-fonts-5.4.3
 then
  rm -rf /sources/oxygen-fonts-5.4.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://download.kde.org/stable/plasma/5.4.3/oxygen-fonts-5.4.3.tar.xz \
    /sources &&

tar xf /sources/oxygen-fonts-5.4.3.tar.xz -C /sources/ &&

cd /sources/oxygen-fonts-5.4.3 &&

as_root install -v -d -m755 /usr/share/fonts/oxygen &&
as_root install -v -m644 oxygen-fonts/Bold-700/*.ttf /usr/share/fonts/oxygen &&
as_root install -v -m644 oxygen-fonts/mono-400/*.ttf /usr/share/fonts/oxygen &&
as_root install -v -m644 oxygen-fonts/Regular-400/*.ttf /usr/share/fonts/oxygen &&
fc-cache -v /usr/share/fonts/oxygen &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
