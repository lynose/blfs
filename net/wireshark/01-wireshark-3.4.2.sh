#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/wireshark-3.4.2
 then
  rm -rf /sources/wireshark-3.4.2
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://www.wireshark.org/download/src/all-versions/wireshark-3.4.2.tar.xz \
        /sources &&
check_and_download https://www.wireshark.org/download/docs/wsdg_html.zip \
        /sources &&
        
check_and_download https://www.wireshark.org/download/docs/wsug_html.zip \
        /sources &&



md5sum -c ${SCRIPTPATH}/md5-wireshark &&

tar xf /sources/wireshark-3.4.2.tar.xz -C /sources/ &&

cd /sources/wireshark-3.4.2 &&

as_root_groupadd groupadd -g 62 wireshark &&

mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/wireshark-3.4.2 \
      -G Ninja \
      .. &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&
${log} `basename "$0"` " built" blfs_all &&

as_root ninja install &&

as_root install -v -m755 -d /usr/share/doc/wireshark-3.4.2 &&
as_root install -v -m644    ../README.linux ../doc/README.* ../doc/{*.pod,randpkt.txt} \
                    /usr/share/doc/wireshark-3.4.2 &&

pushd /usr/share/doc/wireshark-3.4.2 &&
   for FILENAME in ../../wireshark/*.html; do
       as_root ln -s -v -f $FILENAME .
   done
popd
unset FILENAME &&

as_root install -v -m644 /sources/wsdg_html.zip \
                 /usr/share/doc/wireshark-3.4.2 &&
as_root install -v -m644 /sources/wsug_html.zip \
                 /usr/share/doc/wireshark-3.4.2 &&
as_root chown -v root:wireshark /usr/bin/{tshark,dumpcap} &&
as_root chmod -v 6550 /usr/bin/{tshark,dumpcap} &&
as_root usermod -a -G wireshark $USER &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
