#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lua-5.4.2
 then
  as_root rm -rf /sources/lua-5.4.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.lua.org/ftp/lua-5.4.2.tar.gz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/lua-5.4.2-shared_library-1.patch \
    /sources &&
check_and_download http://www.lua.org/tests/lua-5.4.2-tests.tar.gz \
    /sources &&


    
md5sum -c ${SCRIPTPATH}/md5-lua &&

tar xf /sources/lua-5.4.2.tar.gz -C /sources/ &&

cd /sources/lua-5.4.2 &&

cat > lua.pc << "EOF"
V=5.4
R=5.4.2

prefix=/usr
INSTALL_BIN=${prefix}/bin
INSTALL_INC=${prefix}/include
INSTALL_LIB=${prefix}/lib
INSTALL_MAN=${prefix}/share/man/man1
INSTALL_LMOD=${prefix}/share/lua/${V}
INSTALL_CMOD=${prefix}/lib/lua/${V}
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: Lua
Description: An Extensible Extension Language
Version: ${R}
Requires:
Libs: -L${libdir} -llua -lm -ldl
Cflags: -I${includedir}
EOF


patch -Np1 -i ../lua-5.4.2-shared_library-1.patch &&
${log} `basename "$0"` " configured" blfs_all &&

make linux &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  make test &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make INSTALL_TOP=/usr                \
     INSTALL_DATA="cp -d"            \
     INSTALL_MAN=/usr/share/man/man1 \
     TO_LIB="liblua.so liblua.so.5.4 liblua.so.5.4.2" \
     install &&

as_root mkdir -pv                      /usr/share/doc/lua-5.4.2 &&
as_root cp -v doc/*.{html,css,gif,png} /usr/share/doc/lua-5.4.2 &&

as_root install -v -m644 -D lua.pc /usr/lib/pkgconfig/lua.pc &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
