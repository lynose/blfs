#!/bin/bash

if [ ! -d ../sources ]
 then
  mkdir -v ../sources
  chmod -v a+wt ../sources
fi

wget --input-file=./wget-list --continue --directory-prefix=../sources

cp ./md5sums ../sources

pushd ../sources
md5sum -c md5sums
popd
