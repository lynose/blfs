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
Libs: -L${libdir} -llua5.2 -lm -ldl
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

make TO_BIN='lua5.2 luac5.2'                     \
     TO_LIB="liblua5.2.so liblua5.2.so.5.2 liblua5.2.so.5.2.4" \
     INSTALL_DATA="cp -d"                        \
     INSTALL_TOP=$PWD/install/usr                \
     INSTALL_INC=$PWD/install/usr/include/lua5.2 \
     INSTALL_MAN=$PWD/install/usr/share/man/man1 \
     install &&

install -Dm644 lua.pc install/usr/lib/pkgconfig/lua52.pc &&

mkdir -pv install/usr/share/doc/lua-5.2.4 &&
cp -v doc/*.{html,css,gif,png} install/usr/share/doc/lua-5.2.4 &&

ln -s liblua5.2.so install/usr/lib/liblua.so.5.2   &&
ln -s liblua5.2.so install/usr/lib/liblua.so.5.2.4 &&

mv install/usr/share/man/man1/{lua.1,lua5.2.1} &&
mv install/usr/share/man/man1/{luac.1,luac5.2.1} &&

as_root chown -R root:root install  &&
as_root cp -a install/* /
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
