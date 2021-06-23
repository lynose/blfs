#!/bin/bash -l
export CURRENT_PATH=`pwd` &&
export SOURCE_PATH=/sources &&

source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh &&
export MAKEFLAGS='-j 7'  &&
export NINJAJOBS=1 &&
export ENABLE_TEST=false &&
export DANGER_TEST=false &&
#############################################################################
#
#   Global Xorg configuration
#
#############################################################################
as_root chown root:root / #fixes problems with systemd installtion

mkdir -p $SOURCE_PATH/git &&

./X/Xorg/01preXorg.sh &&
./typesetting/01preTeX.sh &&
./kde/01preKF5.sh &&
./devel/java/01-java.sh &&

if [ -f /etc/profile.d/rustc.sh ]
  then
    source /etc/profile.d/rustc.sh
fi
source /etc/profile.d/xorg.sh && # Do not uncomment
source /etc/profile.d/extrapathtex.sh &&
source /etc/profile.d/extrapaths.sh &&
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
#   Packages without required and recommended dependencies
#
#############################################################################
/bin/bash -l ./sec/sudo/01-sudo-1.9.7p1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/OpenSSH/01-openssh-8.6p1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libtasn1/01-libtasn1-4.17.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/p11-kit/01-p11-kit-0.24.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/wget/01-wget-1.21.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/make-ca/01-make-ca-1.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libxml2/01-libxml2-2.9.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/unzip/01-unzip60.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sgml/sgml-common/01-sgml-common-0.6.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libuv/01-libuv-v1.41.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libarchive/01-libarchive-3.5.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/which/01-which-2.21.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libssh2/01-libssh2-1.9.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/libpng/01-libpng-1.6.37.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/acpid/01-acpid-2.0.32.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/LSB-Tools/01-LSB-Tools-0.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/autoconf-old/01-autoconf-2.13.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/python2/01-python2-2.7.18.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/util-macros/01-util-macros-1.19.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/mtdev/01-mtdev-1.1.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/yasm/01-yasm-1.3.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/nasm/01-nasm-2.15.05.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/fdk-aac/01-fdk-aac-2.0.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/cracklib/01-cracklib-2.9.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
# TODO do not build in sudo env --- dangerous need to build PAM again
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/krb5/01-krb5-1.19.1.sh &&
# TODO PAM Config rework, if reinstall
/bin/bash -l ./sec/Linux-PAM/01-Linux-PAM-1.5.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libogg/01-libogg-1.3.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/speex/01-speex-1.2.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./audio-utils/lame/01-lame-3.100.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/frididi/01-fribidi-1.0.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/nspr/01-nspr-4.31.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./db/sqlite/01-sqlite-3.35.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/graphviz/01-graphviz-2.47.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./icons/hicolor-icon-theme/01-hicolor-icon-theme-0.17.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/nettle/01-nettle-3.7.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libunistring/01-libunistring-0.9.10.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/iso-codes/01-iso-codes-4.6.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libgpg-error/01-libgpg-error-1.42.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/sassc/01-sassc-3.6.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/pcre2/01-pcre2-10.37.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libaio/01-libaio-0.3.112.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libatasmart/01-libatasmart-0.19.sh &&
${log} `basename "$0"` " ======================================" blfs_all && 
/bin/bash -l ./gen-libs/inih/01-inih-r53.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/lzo/01-lzo-2.10.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/dosfstools/01-dosfstools-4.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/mdadm/01-mdadm-4.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./audio-utils/cdparanoia/01-cdparanoia-10.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/soundtouch/01-soundtouch-2.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libdvdread/01-libdvdread-6.1.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libtirpc/01-libtirpc-1.3.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libcdio/01-libcdio-2.1.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/npth/01-npth-1.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/lua/01-lua-5.4.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libmad/01-libmad-0.15.1b.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/a52dec/01-a52dev-0.7.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libatomic_ops/01-libatomic_ops-7.6.10.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libpaper/01-libpaper-1.1.24+nmu5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/zip/01-zip-3.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/perl-test-needs/01-Test-Needs-0.002006.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./db/lmdb/01-LMDB_0.9.29.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/giflib/01-giflib-5.2.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libndp/01-libndp-1.8.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/gpm/01-gpm-1.20.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libnl/01-libnl-3.5.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/jansson/01-jansson-2.13.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/iptables/01-iptables-1.8.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/dhcp/01-dhcp-4.4.2-P1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/xapian/01-xapian-1.4.18.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mm/libburn/01-libburn-1.5.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/fftw/01-fftw-3.3.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/perl-net-SSLeay/01-perl-net-SSLeay-1.88.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/unixODBC/01-unixODBC-2.3.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/apr/01-apr-1.7.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/gsl/01-gsl-2.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/id3lib/01-id3lib-3.8.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/rpcsvc-proto/01-rpcsvc-proto-1.4.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/net-tools/01-net-tools-CVS_20101030.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/liblinear/01-liblinear-243.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/wireless_tools/01-wireless_tools-29.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/hdparm/01-hdparm-9.62.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/ntfs-3g/01-ntfs-3g-2017.3.23.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/glm/01-glm-0.9.9.8.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l  ./sys/libelf/01-elfutils-0.183.sh && 
${log} `basename "$0"` " ======================================" blfs_all &&



#############################################################################
#
#   Packages with required or recommended dependencies
#
############################################################################
/bin/bash -l ./sec/sudo/02-sudo-1.9.7p1.sh && # better to build sudo seperate
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/perl-archive-zip/01-archive-zip-1.68.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/python3/01-python-3.9.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/Pygments/01-Pygments-2.9.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/docutils/01-docutils-0.17.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/libcap/01-libcap-2.50.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/bridge-utils/01-bridge-utils-1.7.1.sh && #!!! Need to be reviewed, kernel headers!!!
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/xfsprogs/01-xfsprogs-5.12.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/pm-utils/01-pm-utils-1.4.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libnsl/01-libnsl-1.3.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/iw/01-iw-5.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/rpcbind/01-rpcbind-1.2.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./db/BerkeleyDB/01-db-5.3.28.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/perl-IO-Socket-SSL/01-perl-IO-Socket-SSL-2.071.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/ntp/01-ntp-4.2.8p15.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/perl-URI/01-URI-5.09.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/gc/01-gc-8.0.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libksba/01-libksba-1.6.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/aspell/01-aspell-0.60.8.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libdvdnav/01-libdvdnav-6.1.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libassuan/01-libassuan-2.5.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/LVM2/01-LVM2-2.03.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/parted/01-parted-3.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all && 
/bin/bash -l ./devel/python-libxml2/01-python-libxml2-2.9.10.sh && 
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/nss/01-nss-3.67.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/make-ca/01-make-ca-1.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libgcrypt/01-libgcrypt-1.9.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/MarkupSafe/01-MarkupSafe-2.0.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/Jinja2/01-Jinja2-3.0.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/Mako/01-Mako-1.1.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/lsof/01-lsof-4.91.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/freetype/01-freetype-2.10.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xml/docbook-xsl-nons/01-docbook-xsl-nons-1.79.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/scons/01-scons-4.1.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xml/docbook-xml/01-docbook-xml-4.5.sh && #TODO does not install as user
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xml/itstool/01-itstool-2.0.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libxslt/01-libxslt-1.1.34.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/gtk-doc/01-gtk-doc-1.33.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/p11-kit/01-p11-kit-0.23.22.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libbytesize/01-libbytesize-2.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xml/xmlto/01-xmlto-0.0.28.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/asciidoc/01-asciidoc-9.1.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/btrfs-progs/01-btrfs-progs-5.12.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/pciutils/01-pciutils-3.7.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/curl/01-curl-7.77.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/git/01-git-2.32.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/lz4/01-lz4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libidn2/01-libidn2-2.3.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libpsl/01-libpsl-0.21.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/nghttp2/01-nghttp2-1.43.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/cmake/01-cmake-3.20.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/extra-cmake-modules/01-extra-cmake-modules-5.83.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/plasma-wayland-protocols/01-plasma-wayland-protocols-1.3.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/c-ares/01-c-ares-1.17.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/libjpeg-turbo/01-libjpeg-turbo-2.1.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/qpdf/01-qpdf-10.3.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/jasper/01-jasper-2.0.32.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/lcms2/01-lcms2-2.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/LibRaw/01-LibRaw-0.20.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/libmng/01-libmng-2.0.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/tiff/01-tiff-4.2.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/x265/01-x265-3.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/x264/01-x264-20210211.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/graphite2/01-graphite2-1.3.14.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/json-c/01-json-c-0.15.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/doxygen/01-doxygen-1.9.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/qrencode/01-qrencode-4.1.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/fuse/01-fuse-3.10.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/gavl/01-gavl-1.4.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/frei0r-plugins/01-frei0r-plugins-1.7.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libevent/01-libevent-2.1.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/flac/01-flac-1.3.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/popt/01-popt-1.18.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/logrotate/01-logrotate-3.18.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/rsync/01-rsync-3.2.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libyaml/01-libyaml-0.2.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/PyYAML/01-PyAML-5.3.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/ruby/01-ruby-3.0.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/exiv2/01-exiv2-0.27.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/gnutls/01-gnutls-3.7.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/neon/01-neon-0.31.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libmusicbrainz/01-libmusicbrainz-5.1.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./twb/lynx/01-lynx2.8.9rel.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libdaemon/01-libdaemon-0.14.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/openjpeg/01-openjpeg-2.4.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/opus/01-opus-1.3.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libvpx/01-libvpx-1.10.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libvorbis/01-libvorbis-1.3.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libusb/01-libusb-1.0.24.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/usbutils/01-usbutils-013.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/lm-sensors/01-lm-sensors-3-6-0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/boost/01-boost_1_76_0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/clucene/01-clucene-2.3.3.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/taglib/01-taglib-1.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/llvm/01-llvm.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/rustc/01-rustc-1.52.0.sh && #FIXME Reconfigure ld.so...
source /etc/profile.d/rustc.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/cbindgen/01-cbindgen-0.19.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/pcre/01-pcre-8.45.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./db/mariadb/01-mariadb-10.5.10.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/cyrus-sasl/01-cyrus-sasl-2.1.27.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./server/openldap/01-openldap-2.5.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/curl/02-curl-7.77.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./db/postgresql/01-postgresql-13.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/krb5/02-krb5-1.19.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/nfsutils/01-nfsutils-2.5.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/apr-util/01-apr-util-1.6.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/serf/01-serf-1.3.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./server/apache/01-apache-2.4.48.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/slang/01-slang-2.3.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/newt/01-newt-0.52.21.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/glib/01-glib-2.68.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/sshfs/01-sshfs-3.7.2.sh && #TODO ???
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/swig/01-swig-4.0.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/desktop-file-utils/01-desktop-file-utils-0.26.sh && #TODO Reinstall fails
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/enchant/01-enchant-2.3.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/glib-networking/01-glib-networking-2.68.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/shared-mime-info/01-shared-mime-info-2.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/icu/01-icu-69.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libxml2/02-libxml2-2.9.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/raptor/01-raptor2-2.0.15.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/JS/01-JS-78.11.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/nodejs/01-nodejs-v14.17.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/gptfdisk/01-gptfdisk-1.0.8.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/fontconfig/01-fontconfig-2.13.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/oxygen-fonts/01-oxygen-fonts-5.4.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/noto-fonts/01-Noto-fonts.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/frididi/01-fribidi-1.0.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/polkit/01-polkit-0.119.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/systemd/01-systemd-248.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/libpwquality/01-libpwquality-1.4.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/cryptsetup/01-cryptsetup-2.3.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/gnupg/01-gnupg-2.2.28.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/gpgme/01-gpgme-1.15.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/volume_key/01-volume_key-0.3.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/shadow/01-shadow-4.8.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/alsa-lib/01-alsa-lib-1.2.5.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/audiofile/01-audiofile-0.3.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libsndfile/01-libsndfile-1.0.31.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/sbc/01-sbc-1.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libsamplerate/01-libsamplerate-0.2.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/alsa-plugin/01-alsa-plugin-1.2.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/alsa-utils/01-alsa-utils-1.2.5.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/alsa-firmware/01-alsa-firmware-1.2.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/alsa-oss/01-alsa-oss-1.1.8.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/SDL2/01-SDL2-2.0.14.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libtheora/01-libtheora-1.1.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/harfbuzz/01-harfbuzz-2.8.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libass/01-libass-0.15.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./video-utils/ffmpeg/01-ffmpeg-4.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/wayland/01-wayland-1.19.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/wayland-protocols/01-wayland-protocols-1.21.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xorgproto/01-xorgproto-2021.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/libXau/01-libXau-1.0.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xcb-proto/01-xcb-proto-1.14.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/libXdmcp/01-libXdmcp-1.1.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/libxcb/01-libxcb-1.14.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-Libs/01-Xorg-libs.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/tk/01-tk-8.6.11.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/python3/01-python-3.9.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/meson/01-meson-5.57.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/six/01-six-1.16.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/gdb/01-gdb-10.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/valgrind/01-valgrind-3.17.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/gcc/01-gcc-11.1.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/SDL/01-SDL-1.2.15.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/libwebp/01-libwebp-1.2.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/dbus/01-dbus-1.12.20.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/dbus-glib/01-dbus-glib-0.112.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/vala/01-vala-0.52.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xcb-util/01-xcb-util-0.4.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/startup-notification/01-startup-notification-0.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xcb-util-image/01-xcb-util-image-0.4.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xcb-util-keysyms/01-xcb-util-keysyms-0.4.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xcb-util-renderutil/01-xcb-util-renderutil-0.3.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xcb-util-wm/01-xcb-util-wm-0.4.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xcb-util-cursor/01-xcb-util-cursor-0.1.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/libdrm/01-libdrm-2.4.106.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/libva/01-libva-2.11.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/libvdpau/01-libvdpau-1.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/mesa/01-mesa-21.1.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/libepoxy/01-libepoxy-1.5.8.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/glu/01-glu-9.0.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/freeglut/01-freeglut-3.2.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/libvdpau-va-gl/01-libvdpau-va-gl-0.4.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/libva/01-libva-2.11.0.sh && #TODO Rebuild after mesa
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xbitmaps/01-xbitmaps-1.1.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-apps/01-Xorg-apps.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xsoft/xdg-utils/01-xdg-utils-1.1.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xcursor-themes/01-xcursor-themes-1.0.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-Fonts/01-Xorg-fonts.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xkeyboard-config/01-xkeyboard-config-2.33.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libxkbcommon/01-libxkbcommon-1.3.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libwpe/01-libwpe-1.10.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/wpebackend-fdo/01-wpebackend-fdo-1.10.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/pixman/01-pixman-0.40.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/cairo/01-cairo-1.17.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/pycairo/01-pycairo-1.18.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/pycairo/01-pycairo-1.20.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/gobject-introspection/01-gobject-introspection-1.68.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&    
/bin/bash -l ./X/libxklavier/01-libxklavier-5.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xfce/libxfce4util/01-libxfce4util-4.16.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xfce/xfconf/01-xfconf-4.16.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/gexiv2/01-gexiv2-0.12.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/telepathy-glib/01-telepathy-glib-0.24.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libical/01-libical-3.0.10.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/bluez/01-bluez-5.59.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libpcap/01-libpcap-1.10.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/ldns/01-ldns-1.7.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/harfbuzz/01-harfbuzz-2.8.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libass/01-libass-0.15.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./postscript/mupdf/01-mupdf-1.18.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/freetype/02-freetype-2.10.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/gdk-pixbuf/01-gdk-pixbuf-2.42.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/gdk-pixbuf-xlib/01-gdk-pixbuf-xlib-3116b8ae.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libgusb/01-libgusb-0.3.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libblockdev/01-libblockdev-2.25.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/at-spi2-core/01-at-spi2-core-2.40.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libsoup/01-libsoup-2.72.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/rest/01-rest-0.8.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libgudev/01-libgudev-236.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/colord/01-colord-1.4.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./print/cups/01-cups-2.3.3op2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/openjdk-bin/01-openjdk-15.0.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libmbim/01-libmbim-1.24.8.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libqmi/01-libqmi-1.28.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/ModemManager/01-ModemManager-1.16.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/udisks/01-udisks-2.9.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/libsecret/01-libsecret-0.20.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/pygobject/01-pygobject-2.28.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/pygobject/01-pygobject-3.40.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/upower/01-upower-0.99.12.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/json-glib/01-json-glib-1.6.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/gsettings-desktop-schemas/01-gsettings-desktop-schemas-40.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/atk/01-atk-2.36.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/at-spi2-atk/01-at-spi2-atk-2.38.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/pango/01-pango-1.48.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/gtk+/01-gtk+-3.24.29.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xfce/libxfce4ui/01-libxfce4ui.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xfce/exo/01-exo-4.16.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/gtk+/01-gtk+-2.24.32.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/ssh-askpass/01-ssh-askpass-8.5p1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libiodbc/01-libiodbc-3.52.15.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/gtksourceview/01-gtksourceview-3.24.11.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/gtksourceview4/01-gtksourceview-4.8.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/alsa-tools/01-alsa-tools-1.2.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/libglade/01-libglade-2.6.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xsoft/xscreensaver/01-xscreensaver-6.01.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/pygobject/01-pygobject-2.28.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/pygobject/01-pygobject-3.40.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/pygtk/01-pygtk-2.24.0.sh && 
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/librsvg/01-librsvg-2.50.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./icons/adwaita-icon-theme/01-adwaita-icon-theme-40.1.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/vte/01-vte-0.64.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/gtk-vnc/01-gtk-vnc-1.2.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/GConf/01-GConf-3.2.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./print/ghostscript/01-ghostscript-9.54.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/gstreamer/01-gstreamer-1.18.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/gst-plugins-base/01-gst-plugins-base-1.18.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/gst-plugins-ugly/01-gst-plugins-ugly-1.18.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/gst-plugins-bad/01-gst-plugins-bad-1.18.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/qt5/01-qt5-5.15.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
source /etc/profile.d/qt5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/lightdm/01-lightdm-1.30.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/cmake/02-cmake-3.20.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/doxygen/02-doxygen-1.9.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/graphviz/01-graphviz-2.47.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mm/libburn/02-libburn-1.5.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./icons/oxygen-icons5/01-oxygen-icons5-5.83.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/qca/01-qca-2.3.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/grantlee/01-grantlee-5.2.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/wpa_supplicant/01-wpa_supplicant-2.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/telepathy-mission-control/01-telepathy-mission-control-5.16.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/gobject-introspection/01-gobject-introspection-1.66.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/polkit-qt/01-polkit-qt-0.113.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/libdbusmenu-qt/01-libdbusmenu-qt-0.9.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/pinentry/01-pineentry-1.1.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./typesetting/install-tl-unx/01-install-tl-unx.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/gnupg/01-gnupg-2.2.27.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/gpgme/02-gpgme-1.15.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/pulseaudio/01-pulseaudio-14.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/mlt/01-mlt-6.24.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/v4l-utils/01-v4l-utils-1.20.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/pipewire/01-pipewire-0.3.30.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./audio-utils/mpg123/01-mpg123-1.28.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/phonon/01-phonon-4.11.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/gst-plugins-good/01-gst-plugins-good-1.18.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/phonon-backend-gstreamer/01-phonon-backend-gstreamer-4.10.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libcanberra/01-libcanberra-0.30.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/notification-daemon/01-notification-daemon-3.20.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/libnotify/01-libnotify-0.7.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/lua-5.2/01-lua-5.2.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./video-utils/ffmpeg/02-ffmpeg-4.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./video-utils/vlc/01-vlc-3.0.15.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/phonon-backend-vlc/01-phonon-backend-vlc-0.11.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/webkitgtk/01-webkitgtk-2.32.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/zenity/01-zenity-3.32.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/NetworkManager/01-NetworkManager-1.32.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xsoft/firefox/01-firefox-78.11.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/gcr/01-gcr-3.40.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/gnome-online-accounts/01-gnome-online-accounts-3.40.0.sh && 
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/libgdata/01-libgdata-0.18.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/gnome-keyring/01-gnome-keyring-40.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/subversion/01-subversion-1.14.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/nmap/01-nmap-7.91.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/babl/01-babl-0.1.86.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/gegl/01-gegl-0.4.30.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/libmypaint/01-libmypaint-1.6.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/mypaint-brushes/01-mypaint-brushes-1.3.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/poppler/01-poppler-21.06.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/qtwebengine/01-qtwebengine-5.15.2.sh && 
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./typesetting/texlive/01-texlive-20210325.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/jasper/02-jasper-2.0.32.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/fltk/01-fltk-1.3.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./fsndm/parted/02-parted-3.4.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libassuan/02-libassuan-2.5.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libgcrypt/02-libgcrypt-1.9.3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/rasqal/01-rasqal-0.9.33.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/redland/01-redland-1.0.17.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sys/cpio/01-cpio-2.13.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/openjdk/01-jdk-15.0.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/apache-ant/01-apache-ant-1.10.10.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/bind/01-bind-9.16.18.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/dejavu-fonts/01-dejavu-fonts-2.37.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xsoft/gimp/01-gimp-2.10.24.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen/ImageMagick/01-ImageMagick-7.0.11-0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xsoft/tigervnc/01-tigervnc-1.11.0.sh && 
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/avahi/01-avahi-0.8.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xsoft/pidgin/01-pidgin-2.14.5.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./print/cups-filter/01-cups-filters-1.28.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnome/gvfs/01-gvfs-1.48.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-server/01-xorg-server-1.20.11.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/libevdev/01-libevdev-1.11.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-input-evdev/01-xf86-input-evdev-2.10.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/libinput/01-libinput-1.18.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-input-libinput/01-xf86-input-libinput-1.0.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-input-synaptics/01-xf86-input-synaptics-1.9.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-video-amdgpu/01-xf86-video-amdgpu-19.1.0.sh    &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-video-fbdev/01-xf86-video-fbdev-0.5.0.sh       &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-video-ati/01-xf86-video-ati-19.1.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-video-intel/01-xf86-video-intel-20210222.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-Legacy/01-Xorg-Legacy.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./video-utils/ffmpeg/02-ffmpeg-4.3.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/OpenSSH/02-openssh-8.6p1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/twm/01-twm-1.0.11.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xterm/01-xterm-368.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/xclock/01-xclock-1.0.9.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-xinit/01-xinit-1.4.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/php/01-php-8.0.7.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./scan/sane/01-sane-1.0.29.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kf5/01-kf5-5.83.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/falkon/01-falkon-3.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/ark/01-ark-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./icons/breeze-icons/01-breeze-icons-5.83.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kdenlive/01-kdenlive-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kmix/01-kmix-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/khelpcenter/01-khelpcenter-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/konsole/01-konsole-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/libkkexiv2/01-libkexiv2-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/okular/01-okular-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/libkdcraw/01-libkdcraw-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/gwenview/01-gwenview-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/libkcddb/01-libkcddb-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/k3b/01-k3b-21.04.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/plasma/01-plasma-5.22.1.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/wireshark/01-wireshark-3.4.6.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/orc/01-orc.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./virt/usbredir/01-usbredir.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/spice-protocol/01-spice-protocol.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./xsoft/thunderbird/01-thunderbird-78.11.0.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./office/libreoffice/01-libreoffice-7.1.4.2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/spice/01-spice.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/spice-gtk/01-spice-gtk.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-video-qxl/01-xf86-video-qxl.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./virt/qemu/01-qemu-6.0.0.sh &&

as_root sensors-detect &&
${log} `basename "$0"` " sensors dectected" blfs_all &&

#############################################################################
#
#   Git section
#
############################################################################
/bin/bash -l ./kde/libkomparediff2/01-libkomparediff2.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kate/01-kate.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kpimtexteditor/01-kpimtexteditor.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/akonadi/01-akonadi.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kontactinterface/01-kontactinterface.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/libkdepim/01-libkdepim.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/grantleetheme/01-grantleetheme.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kseexpr/01-kseexpr.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kmime/01-kmime.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/libkleo/01-libkleo.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/akonadi-contacts/01-akonadi-contacts.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kimap/01-kimap.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/opencolorio/01-opencolorio.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/qtkeychain/01-qtkeychain.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kldap/01-kldap.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/eigen3/01-eigen3.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/akonadi-mime/01-akonadi-mime.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/akonadi-search/01-akonadi-search.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/pimcommon/01-pimcommon.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kontact/01-kontact.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kidentitymanagement/01-kidentitymanagement.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/vc/01-vc.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./mld/libheif/01-libheif.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/openexr/01-openexr.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gnf-libs/quazip/01-quazip.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/clazy/01-clazy.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./devel/cppcheck/01-cppcheck.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/ksmtp/01-ksmtp.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/libkgapi/01-libkgapi.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kmailtransport/01-kmailtransport.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/libksieve/01-libksieve.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/gravatar/01-libgravatar.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kmbox/01-kmbox.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/messagelib/01-messagelib.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kcalutils/01-kcalutils.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/mailimporter/01-mailimporter.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/mailcommon/01-mailcommon.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/ktnef/01-ktnef.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kmail/01-kmail.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./X/Xorg/Xorg-drivers/xf86-video-qxl/01-xf86-video-qxl.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./virt/libosinfo/01-libosinfo.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/akonadi-calendar/01-akonadi-calendar.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/akonadi-notes/01-akonadi-notes.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/calendarsupport/01-calendarsupport.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/akonadi-import-wizard/01-akonadi-import-wizard.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/mbox-importer/01-mbox-importer.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/pim-data-exporter/01-pim-data-exporter.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/pim-sieve-editor/01-pim-sieve-editor.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/grantlee-editor/01-grantlee-editor.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kdav/01-kdav.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kdepim-runtime/01-kdepim-runtime.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kdiagram/01-kdiagram.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/eventviews/01-eventviews.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/incidenceeditor/01-incidenceeditor.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kpkpass/01-kpkpass.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kitinerary/01-kitinerary.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kdepim-addons/01-kdepim-addons.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libaccounts-glib/01-libaccounts-glib.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/signond/01-signond.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libaccounts-qt/01-libaccounts-qt.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kaccounts-integration/01-kaccount-integration.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kaccounts-providers/01-kaccount-providers.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kmail-account-wizard/01-kmail-account-wizard.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kuserfeedback/01-kuserfeedback.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/korganizer/01-korganizer.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kaddressbook/01-kaddressbook.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/syndication/01-syndication.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kblog/01-kblog.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/akregator/01-akregator.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libunwind/01-libunwind.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/heaptrack/01-heaptrack.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/okteta/01-okteta.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kdevelop/01-kdevelop.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kdevelop-pg-qt/01-kdevelop-pg-qt.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kdev-php/01-kdev-php.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kdev-python/01-kdev-python.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/knotes/01-knotes.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/baloo-widgets/01-baloo-widgets.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/dolphin/01-dolphin.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/dolphin-plugins/01-dolphin-plugins.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/konqueror/01-konqueror.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/freerdp/01-freerdp.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libvncserver/01-libvncserver.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/krdc/01-krdc.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/kcalc/01-kalc.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./kde/akonadiconsole/01-akonadiconsole.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/libenet/01-libenet.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./gen-libs/libfmt/01-libfmt.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net-libs/gloox/01-gloox-1.0.24.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./sec/libsodium/01-libsodium.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./net/miniupnp/01-miniupnpc.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./audio-utils/openal/01-openal.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./virt/libvirt/01-libvirt.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./virt/libvirt-glib/01-libvirt-glib.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
/bin/bash -l ./virt/virt-manager/01-virt-manager.sh &&
${log} `basename "$0"` " ======================================" blfs_all &&
${log} `basename "$0"` " finished" blfs_all
