#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j 7'
export NINJAJOBS=7
export ENABLE_TEST=false
export DANGER_TEST=false
#############################################################################
#
#   Global Xorg configuration
#
#############################################################################
as_root chown root:root / #fixes problems with systemd installtion

source /etc/profile.d/xorg.sh && # Do not uncomment
source /etc/profile.d/extrapathtex.sh &&
source /etc/profile.d/kf5.sh &&
source /etc/profile.d/qt5.sh &&
source /etc/profile.d/openjdk.sh &&

${log} `basename "$0"` " started" blfs_all &&
${log} `basename "$0"` " ======================================" blfs_all &&
${log} `basename "$0"`  "Started BLFS build" &&
${log} `basename "$0"` " ======================================" blfs_all &&
${log} `basename "$0"` "                                       " blfs_all &&
${log} `basename "$0"` "                                       " blfs_all &&
#############################################################################
#
#   Packages without required and recommended dependencies
#
#############################################################################
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/lua/01-lua-5.4.2.sh &&
# ./X/sddm/01-sddm.sh &&
# ./kde/sddm-kcm/01-sddm-kcm.sh &&
# ./xsoft/tigervnc/01-tigervnc-1.11.0.sh &&
# 
# 
# #############################################################################
# #
# #   Packages with required or recommended dependencies
# #
# ############################################################################
./devel/valgrind/01-valgrind-3.16.1.sh &&
./gnome/zenity/01-zenity-3.32.0.sh &&
./virt/qemu/01-qemu-5.2.0.sh &&
#./sec/nettle/01-nettle-3.7.1.sh && #104
#./devel/llvm/01-llvm.sh &&

${log} `basename "$0"` " ======================================" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
