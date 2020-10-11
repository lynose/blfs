#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/cracklib-2.9.7
 then
  rm -rf /sources/cracklib-2.9.7
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

wget https://github.com/cracklib/cracklib/releases/download/v2.9.7/cracklib-2.9.7.tar.bz2 \
    --continue --directory-prefix=/sources &&
wget https://github.com/cracklib/cracklib/releases/download/v2.9.7/cracklib-words-2.9.7.bz2 \
    --continue --directory-prefix=/sources &&

    
    
md5sum -c ${SCRIPTPATH}/md5-cracklib &&

tar xf /sources/cracklib-2.9.7.tar.bz2 -C /sources/ &&

cd /sources/cracklib-2.9.7 &&

sed -i '/skipping/d' util/packer.c &&

./configure --prefix=/usr    \
            --disable-static \
            --with-default-dict=/lib/cracklib/pw_dict &&
${log} `basename "$0"` " configured" blfs_all &&

make &&
${log} `basename "$0"` " built" blfs_all &&

make install                      &&
mv -v /usr/lib/libcrack.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libcrack.so) /usr/lib/libcrack.so &&



install -v -m644 -D    ../cracklib-words-2.9.7.bz2 \
                         /usr/share/dict/cracklib-words.bz2    &&

bunzip2 -v               /usr/share/dict/cracklib-words.bz2    &&
ln -v -sf cracklib-words /usr/share/dict/words                 &&
echo $(hostname) >>      /usr/share/dict/cracklib-extra-words  &&
install -v -m755 -d      /lib/cracklib                         &&

create-cracklib-dict     /usr/share/dict/cracklib-words \
                         /usr/share/dict/cracklib-extra-words &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
