#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/rustc-1.47.0-src
 then
  rm -rf /sources/rustc-1.47.0-src
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
if [ ! -f /sources/rustc-1.47.0-src.tar.gz ] 
 then
  check_and_download https://static.rust-lang.org/dist/rustc-1.47.0-src.tar.gz \
    /sources
fi

md5sum -c ${SCRIPTPATH}/md5-rustc &&

tar xf /sources/rustc-1.47.0-src.tar.gz -C /sources/ &&

cd /sources/rustc-1.47.0-src &&

as_root mkdir /opt/rustc-1.47.0             &&
if [ -L /opt/rustc ];
 then 
  as_root rm /opt/rustc
fi
as_root ln -svfin rustc-1.47.0 /opt/rustc &&

cat << EOF > config.toml
# see config.toml.example for more possible options
# See the 8.4 book for an example using shipped LLVM
# e.g. if not installing clang, or using a version before 10.0
[llvm]
# by default, rust will build for a myriad of architectures
targets = "X86"

# When using system llvm prefer shared libraries
link-shared = true

[build]
# omit docs to save time and space (default is to build them)
docs = false

# install cargo as well as rust
extended = true

[install]
prefix = "/opt/rustc-1.47.0"
docdir = "share/doc/rustc-1.47.0"

[rust]
channel = "stable"
rpath = false

# BLFS does not install the FileCheck executable from llvm,
# so disable codegen tests
codegen-tests = false

[target.x86_64-unknown-linux-gnu]
# NB the output of llvm-config (i.e. help options) may be
# dumped to the screen when config.toml is parsed.
llvm-config = "/usr/bin/llvm-config"

[target.i686-unknown-linux-gnu]
# NB the output of llvm-config (i.e. help options) may be
# dumped to the screen when config.toml is parsed.
llvm-config = "/usr/bin/llvm-config"
EOF

${log} `basename "$0"` " configured" blfs_all &&

export RUSTFLAGS="$RUSTFLAGS -C link-args=-lffi" &&
python3 ./x.py build --exclude src/tools/miri &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
    python3 ./x.py test --verbose --no-fail-fast | tee rustc-testlog &&
    egrep 'running [[:digit:]]+ test' rustc-testlog | awk '{ sum += $2 } END { print sum }' > /log/rust-summary.log &&
    grep '^test result:' rustc-testlog | awk  '{ sum += $6 } END { print sum }' > /log/rust-failure.log &&
    ${log} `basename "$0"` " check succeed" blfs_all ||
    ${log} `basename "$0"` " expected check fail?" blfs_all
fi

export LIBSSH2_SYS_USE_PKG_CONFIG=1 &&
DESTDIR=${PWD}/install python3 ./x.py install &&
unset LIBSSH2_SYS_USE_PKG_CONFIG &&
as_root chown -R root:root install &&
as_root cp -a install/* / &&
${log} `basename "$0"` " installed" blfs_all &&

cat >> ./rust.conf << EOF &&
# Begin rustc addition

/opt/rustc/lib

# End rustc addition
EOF
    
as_root mv -v ./rust.conf /etc/ld.so.conf.d/


as_root ldconfig &&
${log} `basename "$0"` " ld path configured" blfs_all &&

cat > ./rustc.sh << "EOF" &&
# Begin /etc/profile.d/rustc.sh

pathprepend /opt/rustc/bin           PATH

# End /etc/profile.d/rustc.sh
EOF

as_root mv -v ./rustc.sh /etc/profile.d/rustc.sh 
${log} `basename "$0"` " profile configured" blfs_all &&

${log} `basename "$0"` " finished" blfs_all 
