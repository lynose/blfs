#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/gtk+-3.24.22
 then
  rm -rf /sources/gtk+-3.24.22
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://ftp.gnome.org/pub/gnome/sources/gtk+/3.24/gtk+-3.24.22.tar.xz \
    /sources &&

md5sum --ignore-missing -c ${SCRIPTPATH}/md5-gtk &&

tar xf /sources/gtk+-3.24.22.tar.xz -C /sources/ &&

cd /sources/gtk+-3.24.22 &&



./configure --prefix=/usr              \
            --sysconfdir=/etc          \
            --enable-broadway-backend  \
            --enable-x11-backend       \
            --enable-wayland-backend   \
            --enable-gtk-doc      &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&



if [ ${ENABLE_TEST} == true ]
 then
  as_root glib-compile-schemas /usr/share/glib-2.0/schemas &&
  make check &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root make install &&
as_root gtk-query-immodules-3.0 --update-cache &&
as_root glib-compile-schemas /usr/share/glib-2.0/schemas &&

mkdir -vp ~/.config/gtk-3.0 &&
cat > ~/.config/gtk-3.0/settings.ini << "EOF" &&
[Settings]
gtk-theme-name = Adwaita
gtk-icon-theme-name = oxygen
gtk-font-name = DejaVu Sans 12
gtk-cursor-theme-size = 18
gtk-toolbar-style = GTK_TOOLBAR_BOTH_HORIZ
gtk-xft-antialias = 1
gtk-xft-hinting = 1
gtk-xft-hintstyle = hintslight
gtk-xft-rgba = rgb
gtk-cursor-theme-name = Adwaita
EOF

cat > ~/.config/gtk-3.0/gtk.css << "EOF" &&
*  {
   -GtkScrollbar-has-backward-stepper: 1;
   -GtkScrollbar-has-forward-stepper: 1;
}
EOF

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
