#!/bin/bash
export CURRENT_PATH=`pwd`


source ./help-functions.sh &&

export log=${CURRENT_PATH}/logger.sh
export MAKEFLAGS='-j 2'
export NINJAJOBS=2
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
source /etc/profile.d/kde.sh &&
source /etc/profile.d/plasma.sh &&
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
./sec/ssh-askpass/01-ssh-askpass-8.4p1.sh &&
./devel/python3/01-python-3.9.2.sh && #215
./sys/LSB-Tools/01-LSB-Tools-0.9.sh && 
./devel/Pygments/01-Pygments-2.8.0.sh && #217
./devel/docutils/01-docutils-0.16.sh && #219
./gen-libs/libgcrypt/01-libgcrypt-1.9.2.sh && #263
./devel/MarkupSafe/01-MarkupSafe-1.1.1.sh && #265
./devel/Jinja2/01-Jinja2-2.11.3.sh && #267
./devel/Mako/01-Mako-1.1.4.sh && #269
./devel/scons/01-scons-4.1.0.sh && #277
./xml/itstool/01-itstool-2.0.6.sh && #281
./kde/extra-cmake-modules/01-extra-cmake-modules-5.79.0.sh && #307
./devel/PyYAML/01-PyAML-5.3.1.sh && #363
./sec/krb5/02-krb5-1.19.1.sh && #412
./video-utils/ffmpeg/01-ffmpeg-4.3.2.sh && #494
./devel/python3/01-python-3.9.2.sh && #518
./devel/meson/01-meson-5.57.1.sh && #520
./devel/six/01-six-1.15.0.sh && #522
./devel/pycairo/01-pycairo-1.20.0.sh && #592
./gnome/gexiv2/01-gexiv2-0.12.2.sh && #598
./devel/pygobject/01-pygobject-2.28.7.sh && #652
./devel/pygtk/01-pygtk-2.24.0.sh && #688
./icons/oxygen-icons5/01-oxygen-icons5-5.79.0.sh && #722
./mld/pipewire/01-pipewire-0.3.22.sh && #748
./net/NetworkManager/01-NetworkManager-1.30.0.sh && #772
./xsoft/firefox/01-firefox-78.8.0.sh && #778
./video-utils/ffmpeg/02-ffmpeg-4.3.2.sh && #860
./xsoft/tigervnc/01-tigervnc-1.11.0.sh && #828
./X/Xorg/Xorg-drivers/xf86-video-intel/01-xf86-video-intel-20210222.sh && #856
./kde/kf5/01-kf5-5.79.0.sh && #876
./kde/ark/01-ark-20.12.2.sh && #882
./net/bind/01-bind-9.16.11.sh && #884
./icons/breeze-icons/01-breeze-icons-5.79.0.sh && #886
./kde/kdenlive/01-kdenlive-20.12.2.sh && #886
./kde/kmix/01-kmix-20.12.2.sh && #888
./kde/khelpcenter/01-khelpcenter-20.12.2.sh && #890
./kde/konsole/01-konsole-20.12.2.sh && #892
./kde/libkkexiv2/01-libkexiv2-20.12.2.sh && #894
./kde/okular/01-okular-20.12.2.sh && #896
./kde/libkdcraw/01-libkdcraw-20.12.2.sh && #898
./kde/gwenview/01-gwenview-20.12.2.sh && #900
./kde/libkcddb/01-libkcddb-20.12.2.sh && #902
./kde/k3b/01-k3b-20.12.2.sh && #904
./kde/plasma/01-plasma-5.21.0.sh && #906
./xsoft/thunderbird/01-thunderbird-78.8.0.sh && #914
./virt/virt-manager/01-virt-manager.sh && #1007
${log} `basename "$0"` " ======================================" blfs_all &&

# #############################################################################
# #
# #   Dependencies
# #
# ############################################################################

./kde/libkomparediff2/01-libkomparediff2.sh &&
./kde/kate/01-kate.sh &&
./kde/kpimtexteditor/01-kpimtexteditor.sh &&
./kde/akonadi/01-akonadi.sh &&
./kde/kontactinterface/01-kontactinterface.sh &&
./kde/libkdepim/01-libkdepim.sh &&
./kde/grantleetheme/01-grantleetheme.sh &&
./kde/kseexpr/01-kseexpr.sh &&
./kde/kmime/01-kmime.sh &&
./kde/libkleo/01-libkleo.sh &&
./kde/akonadi-contacts/01-akonadi-contacts.sh &&
./kde/kimap/01-kimap.sh &&
./kde/kldap/01-kldap.sh &&
./kde/akonadi-mime/01-akonadi-mime.sh &&
./kde/akonadi-search/01-akonadi-search.sh &&
./kde/pimcommon/01-pimcommon.sh &&
./kde/kontact/01-kontact.sh &&
./kde/kidentitymanagement/01-kidentitymanagement.sh &&
./kde/ksmtp/01-ksmtp.sh &&
./kde/libkgapi/01-libkgapi.sh &&
./kde/kmailtransport/01-kmailtransport.sh &&
./kde/libksieve/01-libksieve.sh &&
./kde/gravatar/01-libgravatar.sh &&
./kde/kmbox/01-kmbox.sh &&
./kde/messagelib/01-messagelib.sh &&
./kde/kcalutils/01-kcalutils.sh &&
./kde/mailimporter/01-mailimporter.sh &&
./kde/mailcommon/01-mailcommon.sh &&
./kde/ktnef/01-ktnef.sh &&
./kde/kmail/01-kmail.sh &&
./kde/akonadi-calendar/01-akonadi-calendar.sh &&
./kde/akonadi-notes/01-akonadi-notes.sh &&
./kde/calendarsupport/01-calendarsupport.sh &&
./kde/akonadi-import-wizard/01-akonadi-import-wizard.sh &&
./kde/mbox-importer/01-mbox-importer.sh &&
./kde/pim-data-exporter/01-pim-data-exporter.sh &&
./kde/pim-sieve-editor/01-pim-sieve-editor.sh &&
./kde/grantlee-editor/01-grantlee-editor.sh &&
./kde/kdepim-runtime/01-kdepim-runtime.sh &&
./kde/kdiagram/01-kdiagram.sh &&
./kde/eventviews/01-eventviews.sh &&
./kde/incidenceeditor/01-incidenceeditor.sh &&
./kde/kpkpass/01-kpkpass.sh &&
./kde/kitinerary/01-kitinerary.sh &&
./kde/kdepim-addons/01-kdepim-addons.sh &&
./kde/kaccounts-integration/01-kaccount-integration.sh &&
./kde/kaccounts-providers/01-kaccount-providers.sh &&
./kde/kmail-account-wizard/01-kmail-account-wizard.sh &&
./kde/kuserfeedback/01-kuserfeedback.sh &&
./kde/korganizer/01-korganizer.sh &&
./kde/kaddressbook/01-kaddressbook.sh &&
./kde/kblog/01-kblog.sh &&
./kde/akregator/01-akregator.sh &&
./kde/heaptrack/01-heaptrack.sh &&
./kde/okteta/01-okteta.sh &&
./kde/kdevelop/01-kdevelop.sh &&
./kde/kdevelop-pg-qt/01-kdevelop-pg-qt.sh &&
./kde/kdev-php/01-kdev-php.sh &&
./kde/kdev-python/01-kdev-python.sh &&
./kde/knotes/01-knotes.sh &&
./kde/baloo-widgets/01-baloo-widgets.sh &&
./kde/dolphin/01-dolphin.sh &&
./kde/dolphin-plugins/01-dolphin-plugins.sh &&
./kde/konqueror/01-konqueror.sh &&
./kde/krdc/01-krdc.sh &&
./kde/kcalc/01-kalc.sh &&



${log} `basename "$0"` " finished" blfs_all
