#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j 20'
export NINJAJOBS=20
export ENABLE_TEST=false
export DANGER_TEST=false
#############################################################################
#
#   Global Xorg configuration
#
#############################################################################
as_root chown root:root / #fixes problems with systemd installtion

# ./X/Xorg/01preXorg.sh &&
# ./typesetting/01preTeX.sh &&
# ./kde/01preKDE.sh &&
./devel/java/01-java.sh &&

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
# ./sec/sudo/01-sudo-1.9.5p1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/OpenSSH/01-openssh-8.4p1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/wget/01-wget-1.21.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libxml2/01-libxml2-2.9.10.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/unzip/01-unzip60.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sgml/sgml-common/01-sgml-common-0.6.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libuv/01-libuv-v1.40.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libarchive/01-libarchive-3.5.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/which/01-which-2.21.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libssh2/01-libssh2-1.9.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/libtirpc/01-libtirpc-1.3.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/libpng/01-libpng-1.6.37.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/acpid/01-acpid-2.0.32.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/LSB-Tools/01-LSB-Tools-0.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/autoconf-old/01-autoconf-2.13.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/python2/01-python2-2.7.18.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/util-macros/01-util-macros-1.19.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/mtdev/01-mtdev-1.1.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/yasm/01-yasm-1.3.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/nasm/01-nasm-2.15.05.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/fdk-aac/01-fdk-aac-2.0.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/cracklib/01-cracklib-2.9.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# # TODO PAM Config
# ./sec/Linux-PAM/01-Linux-PAM-1.5.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libogg/01-libogg-1.3.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/speex/01-speex-1.2.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./audio-utils/lame/01-lame-3.100.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/frididi/01-fribidi-1.0.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/nspr/01-nspr-4.29.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./db/sqlite/01-sqlite-3.34.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/graphviz/01-graphviz-2.44.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/Pygments/01-Pygments-2.7.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./icons/hicolor-icon-theme/01-hicolor-icon-theme-0.17.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/nettle/01-nettle-3.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libunistring/01-libunistring-0.9.10.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/iso-codes/01-iso-codes-4.5.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libgpg-error/01-libgpg-error-1.41.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/sassc/01-sassc-3.6.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/pcre2/01-pcre2-10.36.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libaio/01-libaio-0.3.112.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libatasmart/01-libatasmart-0.19.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all && 
# ./gen-libs/inih/01-inih-r52.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/lzo/01-lzo-2.10.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/dosfstools/01-dosfstools-4.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/mdadm/01-mdadm-4.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./audio-utils/cdparanoia/01-cdparanoia-10.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/soundtouch/01-soundtouch-2.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libdvdread/01-libdvdread-6.1.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/krb5/01-krb5-1.18.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libcdio/01-libcdio-2.1.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/npth/01-npth-1.6.sh &&
# # # ${log} `basename "$0"` " ======================================" blfs_all &&
# # # ./devel/lua/01-lua-5.4.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libmad/01-libmad-0.15.1b.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/a52dec/01-a52dev-0.7.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libatomic_ops/01-libatomic_ops-7.6.10.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libpaper/01-libpaper-1.1.24+nmu5.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/zip/01-zip-3.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/perl-test-needs/01-Test-Needs-0.002006.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./db/lmdb/01-LMDB_0.9.24.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/giflib/01-giflib-5.2.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/libndp/01-libndp-1.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/gpm/01-gpm-1.20.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/libnl/01-libnl-3.5.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/jansson/01-jansson-2.13.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/iptables/01-iptables-1.8.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/dhcp/01-dhcp-4.4.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/xapian/01-xapian-1.4.17.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mm/libburn/01-libburn-1.5.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/fftw/01-fftw-3.3.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/perl-net-SSLeay/01-perl-net-SSLeay-1.88.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/unixODBC/01-unixODBC-2.3.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/apr/01-apr-1.7.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/gsl/01-gsl-2.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/id3lib/01-id3lib-3.8.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/rpcsvc-proto/01-rpcsvc-proto-1.4.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/net-tools/01-net-tools-CVS_20101030.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/liblinear/01-liblinear-242.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/wireless_tools/01-wireless_tools-29.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/hdparm/01-hdparm-9.60.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/ntfs-3g/01-ntfs-3g-2017.3.23.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/docutils/01-docutils-0.16.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&


#############################################################################
#
#   Packages with required or recommended dependencies
#
############################################################################
# ./sec/sudo/02-sudo-1.9.5p1.sh && # better to build sudo seperate
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/libcap/01-libcap-2.46.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# # ./net/bridge-utils/01-bridge-utils-1.6.sh && #!!! Need to be reviewed, kernel headers!!!
# # ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/xfsprogs/01-xfsprogs-5.10.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/pm-utils/01-pm-utils-1.4.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/libnsl/01-libnsl-1.3.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/iw/01-iw-5.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/rpcbind/01-rpcbind-1.2.5.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./db/BerkeleyDB/01-db-5.3.28.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/qrencode/01-qrencode-4.1.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/perl-IO-Socket-SSL/01-perl-IO-Socket-SSL-2.068.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/ntp/01-ntp-4.2.8p15.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/perl-URI/01-URI-5.05.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/gc/01-gc-8.0.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libksba/01-libksba-1.5.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/aspell/01-aspell-0.60.8.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libdvdnav/01-libdvdnav-6.1.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libassuan/01-libassuan-2.5.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/LVM2/01-LVM2-2.03.11.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/parted/01-parted-3.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/python-libxml2/01-python-libxml2-2.9.10.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/nss/01-nss-3.60.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/make-ca/01-make-ca-1.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libgcrypt/01-libgcrypt-1.8.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/MarkupSafe/01-MarkupSafe-1.1.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/Jinja2/01-Jinja2-2.11.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/Mako/01-Mako-1.1.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/lsof/01-lsof-4.91.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/freetype/01-freetype-2.10.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./xml/docbook-xsl-nons/01-docbook-xsl-nons-1.79.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/scons/01-scons-4.0.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./xml/docbook-xml/01-docbook-xml-4.5.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./xml/itstool/01-itstool-2.0.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libxslt/01-libxslt-1.1.34.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/gtk-doc/01-gtk-doc-1.33.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/p11-kit/01-p11-kit-0.23.22.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libbytesize/01-libbytesize-2.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./xml/xmlto/01-xmlto-0.0.28.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/asciidoc/01-asciidoc-9.0.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/btrfs-progs/01-btrfs-progs-5.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/pciutils/01-pciutils-3.7.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/curl/01-curl-7.74.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/git/01-git-2.30.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libidn2/01-libidn2-2.3.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/libpsl/01-libpsl-0.21.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/nghttp2/01-nghttp2-1.42.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/cmake/01-cmake-3.19.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/extra-cmake-modules/01-extra-cmake-modules-5.77.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/plasma-wayland-protocols/01-plasma-wayland-protocols-1.1.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/c-ares/01-c-ares-1.17.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/libjpeg-turbo/01-libjpeg-turbo-2.0.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/qpdf/01-qpdf-10.1.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/jasper/01-jasper-2.0.14.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/lcms2/01-lcms2-2.11.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/LibRaw/01-LibRaw-0.20.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/libmng/01-libmng-2.0.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/tiff/01-tiff-4.2.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/x265/01-x265-3.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/x264/01-x264-20200819.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/graphite2/01-graphite2-1.3.14.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/json-c/01-json-c-0.15.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/doxygen/01-doxygen-1.9.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/fuse/01-fuse-3.10.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/gavl/01-gavl-1.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/frei0r-plugins/01-frei0r-plugins-1.7.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/libevent/01-libevent-2.1.12.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/flac/01-flac-1.3.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/popt/01-popt-1.18.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/logrotate/01-logrotate-3.18.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/rsync/01-rsync-3.2.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/gpgme/01-gpgme-1.15.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libyaml/01-libyaml-0.2.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/PyYAML/01-PyAML-5.3.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/ruby/01-ruby-3.0.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/exiv2/01-exiv2-0.27.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/gnutls/01-gnutls-3.7.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/neon/01-neon-0.31.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libmusicbrainz/01-libmusicbrainz-5.1.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./twb/lynx/01-lynx2.8.9rel.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libdaemon/01-libdaemon-0.14.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/openjpeg/01-openjpeg-2.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/opus/01-opus-1.3.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libvpx/01-libvpx-1.9.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libvorbis/01-libvorbis-1.3.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libusb/01-libusb-1.0.24.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/usbutils/01-usbutils-013.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/lm-sensors/01-lm-sensors-3-6-0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/boost/01-boost_1_75_0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/taglib/01-taglib-1.11.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/llvm/01-llvm-11.0.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/rustc/01-rustc-1.47.0.sh && #FIXME Reconfigure ld.so...
# source /etc/profile.d/rustc.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/cbindgen/01-cbindgen-0.15.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/pcre/01-pcre-8.44.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./db/mariadb/01-mariadb-10.5.8.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/cyrus-sasl/01-cyrus-sasl-2.1.27.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./server/openldap/01-openldap-2.4.56.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libnfsidmap/01-libnfsidmap-0.26.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/nfsutils/01-nfsutils-2.5.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/apr-util/01-apr-util-1.6.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/serf/01-serf-1.3.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./server/apache/01-apache-2.4.46.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/slang/01-slang-2.3.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/newt/01-newt-0.52.21.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/glib/01-glib-2.66.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/sshfs/01-sshfs-3.7.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/swig/01-swig-4.0.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/desktop-file-utils/01-desktop-file-utils-0.26.sh && #TODO Reinstall fails
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/enchant/01-enchant-2.2.15.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/glib-networking/01-glib-networking-2.66.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/shared-mime-info/01-shared-mime-info-2.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/icu/01-icu-68.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/JS/01-JS-78.6.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/nodejs/01-nodejs-v14.15.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./fsndm/gptfdisk/01-gptfdisk-1.0.5.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/fontconfig/01-fontconfig-2.13.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/oxygen-fonts/01-oxygen-fonts-5.4.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/noto-fonts/01-Noto-fonts.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/frididi/01-fribidi-1.0.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libass/01-libass-0.14.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/polkit/01-polkit-0.118.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/systemd/01-systemd-247.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/libpwquality/01-libpwquality-1.4.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/cryptsetup/01-cryptsetup-2.3.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/volume_key/01-volume_key-0.3.12.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/shadow/01-shadow-4.8.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-lib/01-alsa-lib-1.2.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/audiofile/01-audiofile-0.3.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libsndfile/01-libsndfile-1.0.28.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/sbc/01-sbc-1.5.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libsamplerate/01-libsamplerate-0.1.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-plugin/01-alsa-plugin-1.2.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-utils/01-alsa-utils-1.2.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-firmware/01-alsa-firmware-1.2.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-oss/01-alsa-oss-1.1.8.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/SDL2/01-SDL2-2.0.14.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libtheora/01-libtheora-1.1.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./video-utils/ffmpeg/01-ffmpeg-4.3.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/wayland/01-wayland-1.18.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/wayland-protocols/01-wayland-protocols-1.20.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xorgproto/01-xorgproto-2020.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libXau/01-libXau-1.0.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-proto/01-xcb-proto-1.14.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libXdmcp/01-libXdmcp-1.1.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libxcb/01-libxcb-1.14.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-Libs/01-Xorg-libs.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/tk/01-tk-8.6.10.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/python3/01-python-3.9.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/six/01-six-1.15.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/gdb/01-gdb-10.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/valgrind/01-valgrind-3.16.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/gcc/01-gcc-10.2.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/SDL/01-SDL-1.2.15.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/libwebp/01-libwebp-1.1.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/dbus/01-dbus-1.12.20.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/dbus-glib/01-dbus-glib-0.110.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/vala/01-vala-0.50.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/gexiv2/01-gexiv2-0.12.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util/01-xcb-util-0.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/startup-notification/01-startup-notification-0.12.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-image/01-xcb-util-image-0.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-keysyms/01-xcb-util-keysyms-0.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-renderutil/01-xcb-util-renderutil-0.3.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-wm/01-xcb-util-wm-0.4.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcb-util-cursor/01-xcb-util-cursor-0.1.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libdrm/01-libdrm-2.4.104.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/libva/01-libva-2.10.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/libvdpau/01-libvdpau-1.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/mesa/01-mesa-20.3.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libepoxy/01-libepoxy-1.5.5.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/glu/01-glu-9.0.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/freeglut/01-freeglut-3.2.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/libvdpau-va-gl/01-libvdpau-va-gl-0.4.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/libva/01-libva-2.10.0.sh && # Rebuild after mesa
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xbitmaps/01-xbitmaps-1.1.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-apps/01-Xorg-apps.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./xsoft/xdg-utils/01-xdg-utils-1.1.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xcursor-themes/01-xcursor-themes-1.0.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-Fonts/01-Xorg-fonts.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xkeyboard-config/01-xkeyboard-config-2.31.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libxkbcommon/01-libxkbcommon-1.0.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/pixman/01-pixman-0.40.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/cairo/01-cairo-1.17.2+f93fc72c03e.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/pycairo/01-pycairo-1.18.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/pycairo/01-pycairo-1.20.0.sh &&

# # TODO further check need
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/gobject-introspection/01-gobject-introspection-1.66.1.sh &&

# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/telepathy-glib/01-telepathy-glib-0.24.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libical/01-libical-3.0.8.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/bluez/01-bluez-5.55.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/libpcap/01-libpcap-1.9.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/ldns/01-ldns-1.7.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/harfbuzz/01-harfbuzz-2.7.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./postscript/mupdf/01-mupdf-1.18.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/freetype/02-freetype-2.10.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/gdk-pixbuf/01-gdk-pixbuf-2.42.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libgusb/01-libgusb-0.3.5.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libblockdev/01-libblockdev-2.24.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/at-spi2-core/01-at-spi2-core-2.38.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net-libs/libsoup/01-libsoup-2.72.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/rest/01-rest-0.8.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libgudev/01-libgudev-234.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/colord/01-colord-1.4.5.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./print/cups/01-cups-2.2.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/openjdk-bin/01-openjdk-14.0.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libmbim/01-libmbim-1.24.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/libqmi/01-libqmi-1.26.8.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/ModemManager/01-ModemManager-1.14.8.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/udisks/01-udisks-2.9.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/libsecret/01-libsecret-0.20.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/pygobject/01-pygobject-2.28.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/pygobject/01-pygobject-3.38.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/upower/01-upower-0.99.11.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/json-glib/01-json-glib-1.6.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/gsettings-desktop-schemas/01-gsettings-desktop-schemas-3.38.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/atk/01-atk-2.36.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/at-spi2-atk/01-at-spi2-atk-2.38.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/pango/01-pango-1.48.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/gtk+/01-gtk+-3.24.24.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/gtk+/01-gtk+-2.24.32.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/gtksourceview/01-gtksourceview-3.24.11.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/gtksourceview4/01-gtksourceview-4.8.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/alsa-tools/01-alsa-tools-1.2.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libglade/01-libglade-2.6.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/pygtk/01-pygtk-2.24.0.sh && #TODO Fix
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/librsvg/01-librsvg-2.50.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./icons/adwaita-icon-theme/01-adwaita-icon-theme-3.38.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/vte/01-vte-0.62.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/gtk-vnc/01-gtk-vnc-1.0.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/GConf/01-GConf-3.2.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./print/ghostscript/01-ghostscript-9.53.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/gstreamer/01-gstreamer-1.18.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/gst-plugins-base/01-gst-plugins-base-1.18.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/gst-plugins-ugly/01-gst-plugins-ugly-1.18.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/gst-plugins-bad/01-gst-plugins-bad-1.18.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/qt5/01-qt5-5.15.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/doxygen/02-doxygen-1.9.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/graphviz/01-graphviz-2.44.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./icons/oxygen-icons5/01-oxygen-icons5-5.77.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/qca/01-qca-2.3.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/grantlee/01-grantlee-5.2.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/wpa_supplicant/01-wpa_supplicant-2.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/NetworkManager/01-NetworkManager-1.28.0.sh && #TODO Fix rebuild
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/telepathy-mission-control/01-telepathy-mission-control-5.16.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/polkit-qt/01-polkit-qt-0.113.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/libdbusmenu-qt/01-libdbusmenu-qt-0.9.3.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen-libs/pinentry/01-pineentry-1.1.0.sh &&
# #${log} `basename "$0"` " ======================================" blfs_all &&
# # ./typesetting/install-tl-unx/01-install-tl-unx.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sec/gnupg/01-gnupg-2.2.27.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/pulseaudio/01-pulseaudio-14.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/mlt/01-mlt-6.24.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/v4l-utils/01-v4l-utils-1.20.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/pipewire/01-pipewire-0.3.19.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./audio-utils/mpg123/01-mpg123-1.26.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/phonon/01-phonon-4.11.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/gst-plugins-good/01-gst-plugins-good-1.18.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/phonon-backend-gstreamer/01-phonon-backend-gstreamer-4.10.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./mld/libcanberra/01-libcanberra-0.30.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/notification-daemon/01-notification-daemon-3.20.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/libnotify/01-libnotify-0.7.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./video-utils/vlc/01-vlc-3.0.11.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/phonon-backend-vlc/01-phonon-backend-vlc-0.11.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/webkitgtk/01-webkitgtk-2.30.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./xsoft/firefox/01-firefox-78.6.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/gcr/01-gcr-3.38.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/gnome-online-accounts/01-gnome-online-accounts-3.38.0.sh && #TODO fix rebuidl
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/libgdata/01-libgdata-0.17.13.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/gnome-keyring/01-gnome-keyring-3.36.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/subversion/01-subversion-1.14.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/nmap/01-nmap-7.91.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/babl/01-babl-0.1.84.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gen/gegl/01-gegl-0.4.28.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/libmypaint/01-libmypaint-1.6.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/mypaint-brushes/01-mypaint-brushes-1.3.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnf-libs/poppler/01-poppler-21.01.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/qtwebengine/01-qtwebengine-5.15.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./typesetting/texlive/01-texlive-20200406.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./sys/cpio/01-cpio-2.13.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/openjdk/01-jdk-14.0.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./devel/apache-ant/01-apache-ant-1.10.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/bind/01-bind-9.16.10.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/dejavu-fonts/01-dejavu-fonts-2.37.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./xsoft/gimp/01-gimp-2.10.22.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/avahi/01-avahi-0.8.sh && #@TODO fix useradd 
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./print/cups-filter/01-cups-filters-1.28.7.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./gnome/gvfs/01-gvfs-1.46.2.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-server/01-xorg-server-1.20.10.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/libevdev/01-libevdev-1.10.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/xf86-input-evdev/01-xf86-input-evdev-2.10.6.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/libinput/01-libinput-1.16.4.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/xf86-input-libinput/01-xf86-input-libinput-0.30.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/xf86-input-synaptics/01-xf86-input-synaptics-1.9.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/xf86-video-amdgpu/01-xf86-video-amdgpu-19.1.0.sh    &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/xf86-video-fbdev/01-xf86-video-fbdev-0.5.0.sh       &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/xf86-video-ati/01-xf86-video-ati-19.1.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-drivers/xf86-video-intel/01-xf86-video-intel-20200817.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-Legacy/01-Xorg-Legacy.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./net/OpenSSH/01-openssh-8.4p1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/twm/01-twm-1.0.11.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xterm/01-xterm-363.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/xclock/01-xclock-1.0.9.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./X/Xorg/Xorg-xinit/01-xinit-1.4.1.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./scan/sane/01-sane-1.0.29.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/kf5/01-kf5-5.77.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/ark/01-ark-20.12.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./icons/breeze-icons/01-breeze-icons-5.77.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/kdenlive/01-kdenlive-20.12.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/kmix/01-kmix-20.12.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/khelpcenter/01-khelpcenter-20.12.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/konsole/01-konsole-20.12.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/libkkexiv2/01-libkexiv2-20.12.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/okular/01-okular-20.12.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/libkdcraw/01-libkdcraw-20.12.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
# ./kde/gwenview/01-gwenview-20.08.0.sh &&
# ${log} `basename "$0"` " ======================================" blfs_all &&
./kde/k3b/01-k3b-20.12.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./kde/plasma/01-plasma-5.20.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./net/wireshark/01-wireshark-3.4.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
./virt/qemu/01-qemu-5.2.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&


${log} `basename "$0"` " finished" blfs_all
