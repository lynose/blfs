#!/bin/bash
cd /sources/lua-5.4.2 && 

make INSTALL_TOP=/usr                \
     INSTALL_DATA="cp -d"            \
     INSTALL_MAN=/usr/share/man/man1 \
     TO_LIB="liblua.so liblua.so.5.4 liblua.so.5.4.2" \
     install 
