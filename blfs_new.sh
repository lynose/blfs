#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j 8'
export NINJAJOBS=8
export ENABLE_TEST=false
export DANGER_TEST=false
#############################################################################
#
#   Global Xorg configuration
#
#############################################################################

${log} `basename "$0"` " started" blfs_new &&
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
#./gnf-libs/wxWidgets/01-wxWidgets.sh &&
#./gnf-libs/vulkan/01-vulkan-1.2.162.1.sh &&
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
# #
./typesetting/01preTeX.sh &&


if [ -f /etc/profile.d/rustc.sh ]
  then
    source /etc/profile.d/rustc.sh
fi

source /etc/profile.d/xorg.sh && # Do not uncomment
source /etc/profile.d/extrapathtex.sh &&
source /etc/profile.d/extrapaths.sh &&
source /etc/profile.d/kf5.sh &&
source /etc/profile.d/openjdk.sh &&

/bin/bash -l ./sec/sudo/01-sudo-1.9.7.sh && #47
/bin/bash -l ./net/OpenSSH/01-openssh-8.6p1.sh && #49
/bin/bash -l ./gen-libs/libtasn1/01-libtasn1-4.16.0.sh && #51
/bin/bash -l ./gen-libs/libxml2/01-libxml2-2.9.12.sh && #59
/bin/bash -l ./mld/fdk-aac/01-fdk-aac-2.0.2.sh && #91
/bin/bash -l ./sec/cracklib/01-cracklib-2.9.7.sh && #93
/bin/bash -l ./sec/krb5/01-krb5-1.19.1.sh && #97
/bin/bash -l ./db/sqlite/01-sqlite-3.35.5.sh && #111
/bin/bash -l ./mld/libdvdread/01-libdvdread-6.1.2.sh && #145
/bin/bash -l ./net-libs/libtirpc/01-libtirpc-1.3.2.sh && #147
/bin/bash -l ./db/lmdb/01-LMDB_0.9.29.sh && #167
/bin/bash -l ./sec/iptables/01-iptables-1.8.7.sh && #179
/bin/bash -l ./net/dhcp/01-dhcp-4.4.2-P1.sh && #181
/bin/bash -l ./sys/hdparm/01-hdparm-9.62.sh && #207
/bin/bash -l ./fsndm/ntfs-3g/01-ntfs-3g-2017.3.23.sh && #209
/bin/bash -l ./sec/sudo/02-sudo-1.9.7.sh && # better to build sudo seperate #223
/bin/bash -l ./devel/python3/01-python-3.9.4.sh && #227
/bin/bash -l ./devel/Pygments/01-Pygments-2.9.0.sh && #229
/bin/bash -l ./devel/docutils/01-docutils-0.17.1.sh && #231
/bin/bash -l ./net/rpcbind/01-rpcbind-1.2.6.sh && #245
/bin/bash -l ./gen-libs/libksba/01-libksba-1.5.1.sh && #257
/bin/bash -l ./mld/libdvdnav/01-libdvdnav-6.1.1.sh && #261
/bin/bash -l ./fsndm/LVM2/01-LVM2-2.03.12.sh && #265
/bin/bash -l ./sec/nss/01-nss-3.67.sh && #271
/bin/bash -l ./gen-libs/libgcrypt/01-libgcrypt-1.9.3.sh && #275
/bin/bash -l ./devel/MarkupSafe/01-MarkupSafe-2.0.1.sh && #277
/bin/bash -l ./devel/Jinja2/01-Jinja2-3.0.1.sh && #279
/bin/bash -l ./fsndm/btrfs-progs/01-btrfs-progs-5.12.1.sh && #307
/bin/bash -l ./net-libs/curl/01-curl-7.76.1.sh && #311
/bin/bash -l ./devel/cmake/01-cmake-3.20.2.sh && #323
/bin/bash -l ./gnf-libs/libjpeg-turbo/01-libjpeg-turbo-2.1.0.sh && #333
/bin/bash -l ./gnf-libs/qpdf/01-qpdf-10.3.2.sh && #335
/bin/bash -l ./gnf-libs/jasper/01-jasper-2.0.32.sh && #337
/bin/bash -l ./fsndm/fuse/01-fuse-3.10.3.sh && #357
/bin/bash -l ./gen-libs/popt/01-popt-1.18.sh && #367
/bin/bash -l ./gen-libs/libyaml/01-libyaml-0.2.5.sh && #373
/bin/bash -l ./devel/ruby/01-ruby-3.0.1.sh && #377
/bin/bash -l ./gnf-libs/exiv2/01-exiv2-0.27.3.sh &&
/bin/bash -l ./gen-libs/boost/01-boost_1_76_0.sh && #407
/bin/bash -l ./devel/llvm/01-llvm.sh && #411
/bin/bash -l ./devel/rustc/01-rustc-1.52.0.sh && #FIXME Reconfigure ld.so...
source /etc/profile.d/rustc.sh && #413
/bin/bash -l ./devel/cbindgen/01-cbindgen-0.19.0.sh && #416
/bin/bash -l ./gen-libs/pcre/01-pcre-8.44.sh && ##418
/bin/bash -l ./db/mariadb/01-mariadb-10.5.10.sh && #422
/bin/bash -l ./server/openldap/01-openldap-2.5.4.sh && #424
/bin/bash -l ./net-libs/curl/02-curl-7.76.1.sh && #426
/bin/bash -l ./db/postgresql/01-postgresql-13.3.sh && #428
/bin/bash -l ./sec/krb5/02-krb5-1.19.1.sh && #430
/bin/bash -l ./server/apache/01-apache-2.4.47.sh && #438
/bin/bash -l ./gen-libs/glib/01-glib-2.68.2.sh && #444
/bin/bash -l ./net-libs/glib-networking/01-glib-networking-2.68.1.sh && #454
/bin/bash -l ./gen-libs/icu/01-icu-69.1.sh && #458
/bin/bash -l ./gen-libs/libxml2/02-libxml2-2.9.12.sh && #460
/bin/bash -l ./gen-libs/JS/01-JS-78.10.1.sh && #464
/bin/bash -l ./gen-libs/nodejs/01-nodejs-v14.17.0.sh && #466
/bin/bash -l ./sys/systemd/01-systemd-247.sh && #478
/bin/bash -l ./gen-libs/wayland-protocols/01-wayland-protocols-1.21.sh &&
/bin/bash -l ./X/xorgproto/01-xorgproto-2021.4.sh && #524
/bin/bash -l ./X/libxcb/01-libxcb-1.14.sh && #534
/bin/bash -l ./devel/python3/01-python-3.9.4.sh && #538
/bin/bash -l ./devel/six/01-six-1.16.0.sh && #542
/bin/bash -l ./devel/gdb/01-gdb-10.2.sh && #544
/bin/bash -l ./sys/dbus/01-dbus-1.12.20.sh && #556
/bin/bash -l ./devel/vala/01-vala-0.52.3.sh && #560
/bin/bash -l ./X/libdrm/01-libdrm-2.4.106.sh && #576
/bin/bash -l ./X/mesa/01-mesa-21.1.0.sh && #582
/bin/bash -l ./X/libepoxy/01-libepoxy-1.5.7.sh && #584
/bin/bash -l ./gen-libs/libxkbcommon/01-libxkbcommon-1.3.0.sh && #606
/bin/bash -l ./gen-libs/libical/01-libical-3.0.10.sh && #628
/bin/bash -l ./sys/bluez/01-bluez-5.58.sh && #630
/bin/bash -l ./gnf-libs/harfbuzz/01-harfbuzz-2.8.1.sh && #636
/bin/bash -l ./mld/libass/01-libass-0.15.1.sh && #638
/bin/bash -l ./X/gdk-pixbuf/01-gdk-pixbuf-2.42.6.sh && #644
/bin/bash -l ./X/at-spi2-core/01-at-spi2-core-2.40.1.sh && #652
/bin/bash -l ./print/cups/01-cups-2.3.3op2.sh && #662
/bin/bash -l ./gen-libs/libqmi/01-libqmi-1.28.4.sh && #668
/bin/bash -l ./X/pango/01-pango-1.48.5.sh && ##690
/bin/bash -l ./X/gtk+/01-gtk+-3.24.29.sh && #692
/bin/bash -l ./xfce/exo/01-exo-4.16.2.sh && #696
/bin/bash -l ./gnf-libs/librsvg/01-librsvg-2.50.5.sh && #720
/bin/bash -l ./icons/adwaita-icon-theme/01-adwaita-icon-theme-40.1.1.sh && #722
/bin/bash -l ./gnome/vte/01-vte-0.64.1.sh && #724
/bin/bash -l ./X/gtk-vnc/01-gtk-vnc-1.2.0.sh && #726
/bin/bash -l ./devel/cmake/02-cmake-3.20.2.sh && #746
/bin/bash -l ./gen/graphviz/01-graphviz-2.47.1.sh && #750
/bin/bash -l ./typesetting/install-tl-unx/01-install-tl-unx.sh && #772
/bin/bash -l ./mld/pipewire/01-pipewire-0.3.27.sh && #784
/bin/bash -l ./devel/lua-5.2/01-lua-5.2.4.sh && #800
/bin/bash -l ./video-utils/vlc/01-vlc-3.0.14.sh && #802
/bin/bash -l ./X/webkitgtk/01-webkitgtk-2.32.0.sh && #808
/bin/bash -l ./xsoft/firefox/01-firefox-78.11.0.sh && #814
/bin/bash -l ./gnome/gnome-online-accounts/01-gnome-online-accounts-3.40.0.sh && #818
/bin/bash -l ./devel/subversion/01-subversion-1.14.1.sh && #824
/bin/bash -l ./gnf-libs/poppler/01-poppler-21.05.0.sh && #836
/bin/bash -l ./X/qtwebengine/01-qtwebengine-5.15.2.sh && #838
/bin/bash -l ./gnf-libs/jasper/02-jasper-2.0.32.sh && #842
/bin/bash -l ./X/fltk/01-fltk-1.3.6.sh && #844
/bin/bash -l ./gen-libs/libgcrypt/02-libgcrypt-1.9.3.sh && #850
/bin/bash -l ./sys/cpio/01-cpio-2.13.sh && #854
/bin/bash -l ./devel/apache-ant/01-apache-ant-1.10.10.sh && #860
/bin/bash -l ./net/bind/01-bind-9.16.15.sh && #862
/bin/bash -l ./xsoft/pidgin/01-pidgin-2.14.3.sh && #874
/bin/bash -l ./print/cups-filter/01-cups-filters-1.28.8.sh && #876
/bin/bash -l ./gnome/gvfs/01-gvfs-1.48.1.sh && #878
/bin/bash -l ./X/Xorg/Xorg-server/01-xorg-server-1.20.11.sh && #880 
/bin/bash -l ./X/Xorg/Xorg-drivers/libinput/01-libinput-1.17.2.sh && #886
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-input-libinput/01-xf86-input-libinput-1.0.1.sh && #888
/bin/bash -l ./net/OpenSSH/02-openssh-8.6p1.sh && #904
/bin/bash -l ./devel/php/01-php-8.0.6.sh && #914
/bin/bash -l ./net/wireshark/01-wireshark-3.4.5.sh && #948
/bin/bash -l ./xsoft/thunderbird/01-thunderbird-78.10.1.sh && #956
/bin/bash -l ./office/libreoffice/01-libreoffice-7.1.3.2.sh && #958
/bin/bash -l ./virt/qemu/01-qemu-6.0.0.sh && #966

${log} `basename "$0"` " finished" blfs_all
