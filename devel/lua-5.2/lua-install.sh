#!/bin/bash
cd /sources/lua-5.2.4 && 

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

chown -R root:root install  &&
cp -a install/* /
