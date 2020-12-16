#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/fuse-3.9.3
 then
  rm -rf /sources/fuse-3.9.3
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/libfuse/libfuse/releases/download/fuse-3.9.3/fuse-3.9.3.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-fuse &&

tar xf /sources/fuse-3.9.3.tar.xz -C /sources/ &&

cd /sources/fuse-3.9.3 &&

sed -i '/^udev/,$ s/^/#/' util/meson.build &&

mkdir build &&
cd    build &&

meson --prefix=/usr .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
doxygen ../doc/Doxyfile &&
${log} `basename "$0"` " built" blfs_all &&

# if [ ${ENABLE_TEST} == true ]
#  then
#   python3 -m pytest test && #PYTEST needed
#   ${log} `basename "$0"` " unexpected check succeed" blfs_all
#   ${log} `basename "$0"` " expected check fail?" blfs_all
# fi

as_root ninja install &&

as_root mv -vf   /usr/lib/libfuse3.so.3*     /lib                 &&
as_root ln -sfvn ../../lib/libfuse3.so.3.9.3 /usr/lib/libfuse3.so &&

as_root mv -vf /usr/bin/fusermount3  /bin         &&
as_root mv -vf /usr/sbin/mount.fuse3 /sbin        &&
as_root chmod u+s /bin/fusermount3                &&

as_root install -v -m755 -d /usr/share/doc/fuse-3.9.3      &&
as_root install -v -m644    ../doc/{README.NFS,kernel.txt} \
                    /usr/share/doc/fuse-3.9.3      &&
as_root cp -Rv ../doc/html  /usr/share/doc/fuse-3.9.3 &&

cat > ./fuse.conf << "EOF" &&
# Set the maximum number of FUSE mounts allowed to non-root users.
# The default is 1000.
#
#mount_max = 1000

# Allow non-root users to specify the 'allow_other' or 'allow_root'
# mount options.
#
#user_allow_other
EOF
as_root mv -f ./fuse.conf /etc/fuse.conf &&


${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
