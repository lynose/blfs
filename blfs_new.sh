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

./kde/01preKF5.sh &&
./kde/01preKDE.sh &&
./kde/01prePlasma.sh &&

source /etc/profile.d/xorg.sh && # Do not uncomment
source /etc/profile.d/extrapathtex.sh &&
source /etc/profile.d/qt5.sh &&
source /etc/profile.d/kf5.sh &&

source /etc/profile.d/openjdk.sh &&

${log} `basename "$0"` " started" blfs_all &&
${log} `basename "$0"` " ======================================" blfs_all &&
${log} `basename "$0"`  "Started BLFS build" &&
${log} `basename "$0"` " ======================================" blfs_all &&
${log} `basename "$0"` "                                       " blfs_all &&
${log} `basename "$0"` "                                       " blfs_all &&
#############################################################################
#
#   Staging
#
#############################################################################
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/lua/01-lua-5.4.2.sh &&
# ./X/sddm/01-sddm.sh &&
# ./kde/sddm-kcm/01-sddm-kcm.sh &&
# 
# 
# #############################################################################
# #
# #   New in version
# #
# ############################################################################

# #############################################################################
# #
# #   Dependencies
# #
# ############################################################################
./kde/akonadiconsole/01-akonadiconsole.sh &&
./gen-libs/lz4/01-lz4.sh &&
./mld/orc/01-orc.sh &&
./virt/usbredir/01-usbredir.sh &&
./X/spice-protocol/01-spice-protocol.sh &&
./X/spice/01-spice.sh &&
./X/spice-gtk/01-spice-gtk.sh &&
./X/Xorg/Xorg-drivers/xf86-video-qxl/01-xf86-video-qxl.sh &&
./virt/qemu/01-qemu-5.2.0.sh &&
./virt/libvirt/01-libvirt.sh &&
${log} `basename "$0"` " finished" blfs_all
