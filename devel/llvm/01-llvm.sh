#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

url=https://github.com/llvm/llvm-project.git
version="llvmorg-12.0.1"

gitget $url \
        /sources \
        $version &&

pack=`basename ${url}`
packname=${pack:0: -4}
gitpack=/sources/git/${packname}

cd ${gitpack} &&

grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/' &&

if [ -d ./build ]
 then
   as_root rm -rf build
fi

mkdir -v build &&
cd       build &&

CC=gcc CXX=g++                            \
cmake -DCMAKE_INSTALL_PREFIX=/usr               \
      -DLLVM_ENABLE_FFI=ON                      \
      -DCMAKE_BUILD_TYPE=Release                \
      -DLLVM_BUILD_LLVM_DYLIB=ON                \
      -DLLVM_LINK_LLVM_DYLIB=ON                 \
      -DLLVM_ENABLE_RTTI=ON                     \
      -DLLVM_TARGETS_TO_BUILD="host;AMDGPU;BPF" \
      -DLLVM_BUILD_TESTS=ON                     \
      -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt;" \
      -Wno-dev -G Ninja ../llvm    &&
${log} `basename "$0"` " configured" blfs_all &&

ninja &&

${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  ninja check-all &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root ninja install &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
