#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j7'
export NINJAJOBS=7
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

#./kde/01preKF5.sh &&


if [ -f /etc/profile.d/rustc.sh ]
  then
    source /etc/profile.d/rustc.sh
fi

source /etc/profile.d/xorg.sh && # Do not uncomment
source /etc/profile.d/extrapathtex.sh &&
source /etc/profile.d/extrapaths.sh &&
source /etc/profile.d/kf5.sh &&
source /etc/profile.d/openjdk.sh &&

#/bin/bash -l ./fsndm/btrfs-progs/01-btrfs-progs-5.12.1.sh && #307
#/bin/bash -l ./sys/pciutils/01-pciutils-3.7.0.sh && #309
# /bin/bash -l ./server/openldap/01-openldap-2.5.5.sh && #424
# /bin/bash -l ./net-libs/curl/02-curl-7.77.0.sh && #426
#/bin/bash -l ./sec/polkit/01-polkit-0.119.sh && #478
#/bin/bash -l ./xfce/exo/01-exo-4.16.2.sh && #696

/bin/bash -l ./kde/kf5/01-kf5-5.83.0.sh && #922
/bin/bash -l ./kde/ark/01-ark-21.04.2.sh && #926
/bin/bash -l ./kde/kdenlive/01-kdenlive-21.04.2.sh && #930
/bin/bash -l ./kde/kmix/01-kmix-21.04.2.sh && #932
/bin/bash -l ./kde/khelpcenter/01-khelpcenter-21.04.2.sh && #934
/bin/bash -l ./kde/konsole/01-konsole-21.04.2.sh && #936
/bin/bash -l ./kde/libkkexiv2/01-libkexiv2-21.04.2.sh && #938
/bin/bash -l ./kde/okular/01-okular-21.04.2.sh && #940
/bin/bash -l ./kde/libkdcraw/01-libkdcraw-21.04.2.sh && #942
/bin/bash -l ./kde/gwenview/01-gwenview-21.04.2.sh && #944
/bin/bash -l ./kde/libkcddb/01-libkcddb-21.04.2.sh && #946
/bin/bash -l ./kde/k3b/01-k3b-21.04.2.sh && #948
/bin/bash -l ./kde/plasma/01-plasma-5.22.1.sh && #950

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
