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
# 
./net/OpenSSH/01-openssh-8.5p1.sh && #42
./gen-libs/liblinear/01-liblinear-243.sh && #198
./devel/perl-IO-Socket-SSL/01-perl-IO-Socket-SSL-2.070.sh && #241
./devel/perl-URI/01-URI-5.09.sh && #245
./sec/nss/01-nss-3.62.sh && #263
./devel/cmake/01-cmake-3.19.6.sh && #313
./gnf-libs/qpdf/01-qpdf-10.2.0.sh && #325
./devel/cbindgen/01-cbindgen-0.18.0.sh && #408
./db/mariadb/01-mariadb-10.5.9.sh && #412
./X/xorgproto/01-xorgproto-2021.3.sh #508
./devel/python3/01-python-3.9.2.sh && #522
./devel/vala/01-vala-0.50.4.sh && #544
./sys/bluez/01-bluez-5.56.sh && #614
./gen-libs/libqmi/01-libqmi-1.28.2.sh && #650
./sys/ModemManager/01-ModemManager-1.16.2.sh && #652
./X/gtk+/01-gtk+-3.24.26.sh && #674
./gen-libs/libiodbc/01-libiodbc-3.52.14.sh && #682
./X/gtksourceview4/01-gtksourceview-4.8.1.sh && #686
./devel/cmake/02-cmake-3.19.6.sh && #722
./gnf-libs/babl/01-babl-0.1.86.sh && #800
./gnf-libs/poppler/01-poppler-21.03.0.sh && #808
./X/Xorg/Xorg-drivers/libinput/01-libinput-1.17.0.sh && #858
./net/OpenSSH/02-openssh-8.5p1.sh && #876
./devel/php/01-php-8.0.2.sh &&
./gnf-libs/vulkan/01-vulkan-1.2.162.1.sh &&

${log} `basename "$0"` " finished" blfs_all
