#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/xscreensaver-6.00
 then
  rm -rf /sources/xscreensaver-6.00
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.jwz.org/xscreensaver/xscreensaver-6.00.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-xscreensaver &&

tar xf /sources/xscreensaver-6.00.tar.gz -C /sources/ &&

cd /sources/xscreensaver-6.00 &&

./configure --prefix=/usr --with-setuid-hacks &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

as_root make install &&

cat > /tmp/xscreensaver << "EOF" &&
# Begin /etc/pam.d/xscreensaver

auth    include system-auth
account include system-account

# End /etc/pam.d/xscreensaver
EOF
as_root mv -v /tmp/xscreensaver /etc/pam.d/xscreensaver &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
