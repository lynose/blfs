#!/bin/bash

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
./gen-libs/libxml2/01-libxml2-2.9.10.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/unzip/01-unzip60.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sgml/sgml-common/01-sgml-common-0.6.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/libuv/01-libuv-v1.18.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/libarchive/01-libarchive-3.4.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/which/01-which-2.21.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/libssh2/01-libssh2-1.9.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/acpid/01-acpid-2.0.32.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/LSB-Tools/01-LSB-Tools-0.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./devel/autoconf-old/01-autoconf-2.13.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./devel/python2/01-python2-2.7.18.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&

./sec/cracklib/01-cracklib-2.9.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sec/Linux-PAM/01-Linux-PAM-1.4.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&


#############################################################################
#
#   Packages with required or recommended dependencies
#
#############################################################################

./xml/docbook-xsl-nons/01-docbook-xsl-nons-1.79.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./xml/docbook-xml/01-docbook-xml-4.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&

./gen-libs/libxslt/01-libxslt-1.1.34.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/pciutils/01-pciutils-3.7.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./net-libs/curl/01-curl-7.71.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./devel/git/01-git-2.28.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./net-libs/nghttp2/01-nghttp2-1.41.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./devel/cmake/01-cmake-3.18.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/json-c/01-json-c-0.15.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./devel/doxygen/01-doxygen-1.8.19.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/libusb/01-libusb-1.0.23.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/usbutils/01-usbutils-012.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/lm-sensors/01-lm-sensors-3-6-0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/boost/01-boost_1_74_0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./devel/llvm/01-llvm-10.0.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/JS/01-JS-68.11.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/pcre/01-pcre-8.44.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/glib/01-glib-2.64.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./gen-libs/icu/01-icu-67.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sec/polkit/01-polkit-0.117.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sys/systemd/01-systemd-246.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sec/libpwquality/01-libpwquality-1.4.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./sec/shadow/01-shadow-4.8.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&

${log} `basename "$0"` " finished" blfs_all
