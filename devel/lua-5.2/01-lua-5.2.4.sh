#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/lua-5.2.4
 then
  as_root rm -rf /sources/lua-5.2.4
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://www.lua.org/ftp/lua-5.2.4.tar.gz \
    /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/lua-5.2.4-shared_library-1.patch \
    /sources &&
    
md5sum -c ${SCRIPTPATH}/md5-lua &&

tar xf /sources/lua-5.2.4.tar.gz -C /sources/ &&

cd /sources/lua-5.2.4 &&

cat > lua.pc << "EOF" &&
V=5.2
R=5.2.4

prefix=/usr
INSTALL_BIN=${prefix}/bin
INSTALL_INC=${prefix}/include/lua5.2
INSTALL_LIB=${prefix}/lib
INSTALL_MAN=${prefix}/share/man/man1
INSTALL_LMOD=${prefix}/share/lua/${V}
INSTALL_CMOD=${prefix}/lib/lua/${V}
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include/lua5.2

Name: Lua
Description: An Extensible Extension Language
Version: ${R}
Requires:
Libs: -L${libdir} -llua -lm -ldl
Cflags: -I${includedir}
EOF

patch -Np1 -i ../lua-5.2.4-shared_library-1.patch &&
sed -i '/#define LUA_ROOT/s:/usr/local/:/usr/:' src/luaconf.h &&

sed -r -e '/^LUA_(SO|A|T)=/ s/lua/lua5.2/' \
       -e '/^LUAC_T=/ s/luac/luac5.2/'     \
       -i src/Makefile &&
${log} `basename "$0"` " configured" blfs_all &&

make MYCFLAGS="-fPIC" linux &&
${log} `basename "$0"` " built" blfs_all &&

as_root ${SCRIPTPATH}/lua-install.sh &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
