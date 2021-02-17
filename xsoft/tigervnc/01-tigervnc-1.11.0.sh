#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/tigervnc-1.11.0
 then
  rm -rf /sources/tigervnc-1.11.0
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/TigerVNC/tigervnc/archive/v1.11.0/tigervnc-1.11.0.tar.gz \
        /sources &&
check_and_download https://www.x.org/pub/individual/xserver/xorg-server-1.20.7.tar.bz2 \
        /sources &&
check_and_download http://www.linuxfromscratch.org/patches/blfs/svn/tigervnc-1.11.0-configuration_fixes-1.patch \
        /sources &&

md5sum -c ${SCRIPTPATH}/md5-tigervnc &&

tar xf /sources/tigervnc-1.11.0.tar.gz -C /sources/ &&

cd /sources/tigervnc-1.11.0 &&

patch -Np1 -i ../tigervnc-1.11.0-configuration_fixes-1.patch &&

# Put code in place
mkdir -p unix/xserver &&
tar -xf ../xorg-server-1.20.7.tar.bz2 \
    --strip-components=1              \
    -C unix/xserver                   &&
( cd unix/xserver &&
  patch -Np1 -i ../xserver120.patch ) &&
${log} `basename "$0"` " configured" blfs_all &&

# Build viewer
cmake -G "Unix Makefiles"         \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -Wno-dev . &&
make &&
${log} `basename "$0"` " built vnc viewer" blfs_all &&

# Build server
pushd unix/xserver &&
  autoreconf -fiv  &&

  CFLAGS="$CFLAGS -I/usr/include/drm" \
  ./configure $XORG_CONFIG            \
      --disable-xwayland    --disable-dri        --disable-dmx         \
      --disable-xorg        --disable-xnest      --disable-xvfb        \
      --disable-xwin        --disable-xephyr     --disable-kdrive      \
      --disable-devel-docs  --disable-config-hal --disable-config-udev \
      --disable-unit-tests  --disable-selective-werror                 \
      --disable-static      --enable-dri3                              \
      --without-dtrace      --enable-dri2        --enable-glx          \
      --with-pic &&
  make  &&
popd
${log} `basename "$0"` " built vnc server" blfs_all &&

as_root make install &&
${log} `basename "$0"` " installed vnc viewer" blfs_all &&
#Install server
( cd unix/xserver/hw/vnc && as_root make install ) &&
${log} `basename "$0"` " installed vnc server" blfs_all &&
[ -e /usr/bin/Xvnc ] || as_root ln -svf $XORG_PREFIX/bin/Xvnc /usr/bin/Xvnc

as_root install -m755 --owner=root ../vncserver /usr/bin &&
as_root cp ../vncserver.1 /usr/share/man/man1 &&


if [ EUID != 0 ]
 then
  if [ ! -d ~/.vnc ]
   then
    mkdir ~/.vnc
  fi
  if [ ! -f ~/.vnc/xstartup ]
   then
    cat > ~/.vnc/xstartup << "EOF"
#!/bin/sh
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
startplasma-x11 &
EOF
  fi
fi

as_root install -vdm755 /etc/X11/tigervnc &&
as_root install -v -m755 ../Xsession /etc/X11/tigervnc &&

as_root echo ":1=$(whoami)" >> /etc/tigervnc/vncserver.users &&

cat > ~/.vnc/config << EOF
# Begin ~/.vnc/config

session=plasma      # The session must match one listed in /usr/share/xsessions.
geometry=1920x1080

# End ~/.vnc/config
EOF
as_root systemctl start vncserver@:1
as_root systemctl enable vncserver@:1

${log} `basename "$0"` " finished" blfs_all 
