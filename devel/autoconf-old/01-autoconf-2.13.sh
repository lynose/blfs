#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/autoconf-2.13
 then
  rm -rf /sources/autoconf-2.13
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://ftp.gnu.org/gnu/autoconf/autoconf-2.13.tar.gz \
    --continue --directory-prefix=/sources &&
wget http://www.linuxfromscratch.org/patches/blfs/10.0/autoconf-2.13-consolidated_fixes-1.patch \
    --continue --directory-prefix=/sources &&
    
    
md5sum -c ${SCRIPTPATH}/md5-autoconf-old &&

tar xf /sources/autoconf-2.13.tar.gz -C /sources/ &&

cd /sources/autoconf-2.13 &&

patch -Np1 -i ../autoconf-2.13-consolidated_fixes-1.patch &&
mv -v autoconf.texi autoconf213.texi                      &&
rm -v autoconf.info                                       &&
./configure --prefix=/usr --program-suffix=2.13           &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make check &&
${log} `basename "$0"` " check succeed" blfs_all &&

make install                                      &&
install -v -m644 autoconf213.info /usr/share/info &&
install-info --info-dir=/usr/share/info autoconf213.info &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
