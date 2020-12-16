#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gcc-10.2.0
 then
  rm -rf /sources/gcc-10.2.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz \
        /sources


md5sum -c ${SCRIPTPATH}/md5-gcc &&

tar xf /sources/gcc-10.2.0.tar.xz -C /sources/ &&

cd /sources/gcc-10.2.0 &&

case $(uname -m) in
  x86_64)
    sed -i.orig '/m64=/s/lib64/lib/' gcc/config/i386/t-linux64
  ;;
esac

mkdir build                                            &&
cd    build                                            &&

../configure                                           \
    --prefix=/usr                                      \
    --disable-multilib                                 \
    --with-system-zlib                                 \
    --enable-languages=c,c++,d,fortran,go,objc,obj-c++ &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ulimit -s 32768 &&
  make -k check &&
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root mkdir -pv /usr/share/gdb/auto-load/usr/lib              &&
as_root mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib &&

as_root chown -v -R root:root \
    /usr/lib/gcc/*linux-gnu/10.2.0/include{,-fixed}

as_root rm -rf /usr/lib/gcc/$(gcc -dumpmachine)/10.2.0/include-fixed/bits/ &&
as_root ln -v -sf ../usr/bin/cpp /lib          &&
as_root ln -v -sf gcc /usr/bin/cc              &&
as_root install -v -dm755 /usr/lib/bfd-plugins &&
as_root ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/10.2.0/liblto_plugin.so /usr/lib/bfd-plugins/ &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
