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
# 
# 
# 
# #############################################################################
# #
# #   Packages with required or recommended dependencies
# #
# ############################################################################
#./X/sddm/01-sddm.sh &&
#./kde/sddm-kcm/01-sddm-kcm.sh &&
./gen-libs/libgcrypt/01-libgcrypt-1.9.2.sh && #259
./devel/cmake/01-cmake-3.19.5.sh && #307
./mld/x264/01-x264-20210211.sh && #331
./X/xkeyboard-config/01-xkeyboard-config-2.32.sh && #578
./X/libxklavier/01-libxklavier-5.4.sh && #592 new
./xfce/libxfce4util/01-libxfce4util-4.16.0.sh && #592 new
./xfce/xfconf/01-xfconf-4.16.0.sh && #594 new
./gen-libs/libqmi/01-libqmi-1.26.10.sh && #634
./xfce/libxfce4ui/01-libxfce4ui.sh && #664 new
./xfce/exo/01-exo-4.16.0.sh && #666 new
./gnome/vte/01-vte-0.62.3.sh && #680
./devel/cmake/02-cmake-3.19.5.sh && #698
./X/lightdm/01-lightdm-1.30.0.sh &&
./gen-libs/libgcrypt/02-libgcrypt-1.9.2.sh && #796
./net/bind/01-bind-9.16.12.sh &&
#./xsoft/tigervnc/01-tigervnc-1.11.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
