#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xterm-359
 then
  rm -rf /sources/xterm-359
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://invisible-mirror.net/archives/xterm/xterm-359.tgz \
    /sources &&

md5sum -c ${SCRIPTPATH}/md5-xterm &&

tar xf /sources/xterm-359.tgz -C /sources/ &&

cd /sources/xterm-359 &&

sed -i '/v0/{n;s/new:/new:kb=^?:/}' termcap &&
printf '\tkbs=\\177,\n' >> terminfo &&

TERMINFO=/usr/share/terminfo \
./configure $XORG_CONFIG     \
    --with-app-defaults=/etc/X11/app-defaults &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install    &&
as_root make install-ti &&

as_root mkdir -pv /usr/share/applications &&
as_root cp -v *.desktop /usr/share/applications/ &&
${log} `basename "$0"` " installed" blfs_all &&

as_root cat >> /etc/X11/app-defaults/XTerm << "EOF"
*VT100*locale: true
*VT100*faceName: Monospace
*VT100*faceSize: 10
*backarrowKeyIsErase: true
*ptyInitialErase: true
EOF

${log} `basename "$0"` " finished" blfs_all 
