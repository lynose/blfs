#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/fuse-3.10.4
 then
  as_root rm -rf /sources/fuse-3.10.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/libfuse/libfuse/releases/download/fuse-3.10.4/fuse-3.10.4.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-fuse &&

tar xf /sources/fuse-3.10.4.tar.xz -C /sources/ &&

cd /sources/fuse-3.10.4 &&

sed -i '/^udev/,$ s/^/#/' util/meson.build &&

mkdir build &&
cd    build &&

meson --prefix=/usr --buildtype=release .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
doxygen ../doc/Doxyfile &&
${log} `basename "$0"` " built" blfs_all &&

#TODO PYTEST needed
if [ ${ENABLE_TEST} == true ]
 then
  python3 -m pytest test && 
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

ninja install                                             &&

chmod u+s /usr/bin/fusermount3                &&

install -v -m755 -d /usr/share/doc/fuse-3.10.4      &&
install -v -m644    ../doc/{README.NFS,kernel.txt} \
                    /usr/share/doc/fuse-3.10.4      &&
cp -Rv ../doc/html  /usr/share/doc/fuse-3.10.4 &&

cat > ./fuse.conf << "EOF" &&
# Set the maximum number of FUSE mounts allowed to non-root users.
# The default is 1000.
#
mount_max = 100

# Allow non-root users to specify the 'allow_other' or 'allow_root'
# mount options.
#
#user_allow_other
EOF
as_root mv -f ./fuse.conf /etc/fuse.conf &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
