#!/bin/bash

find . -name '*.sh' -exec grep 'continue --directory-prefix=/sources'
