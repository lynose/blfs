#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/sudo-1.9.7p1
 then
  rm -rf /sources/sudo-1.9.7p1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.sudo.ws/dist/sudo-1.9.7p1.tar.gz \
        /sources &&


md5sum -c ${SCRIPTPATH}/md5-sudo &&

tar xf /sources/sudo-1.9.7p1.tar.gz -C /sources/ &&

cd /sources/sudo-1.9.7p1 &&

./configure --prefix=/usr              \
            --libexecdir=/usr/lib      \
            --with-secure-path         \
            --with-all-insults         \
            --with-env-editor          \
            --docdir=/usr/share/doc/sudo-1.9.7p1 \
            --with-passprompt="[sudo] password for %p: "  &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  env LC_ALL=C make check 2>&1 &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
  cp ../make-check.log /log/sudo1-make-check.log
fi

as_root make install &&
as_root ln -sfv libsudo_util.so.0.0.0 /usr/lib/sudo/libsudo_util.so.0 &&

as_root test -f /etc/sudoers.d/sudo && RES=true || RES=false
echo $RES
if [ $RES == false ]
 then
  cat > ./sudoers.sudo << "EOF" &&
Defaults secure_path="/usr/bin:/bin:/usr/sbin:/sbin"
%wheel ALL=(ALL) ALL
EOF
  echo "$USER ALL=(ALL) NOPASSWD : ALL" >> ./sudoers.sudo &&
  as_root install -vm644 --owner=root --group=root ./sudoers.sudo /etc/sudoers.d/sudo 
  
fi
unset RES

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 