#!/bin/bash
INFO=$2
SCRIPTNAME=$1
STAGE=$3
LOGPATH=""
LOGFILE=""

if [ -d $LFS ]
  then
    LOGPATH=${LFS}
fi

if [ -d $LFS/log ]
  then
    LOGPATH="${LOGPATH}/log"
  else
    LOGPATH="/log"
fi

if [ -n ${STAGE} ]
  then
    LOGFILE="${STAGE}.log"
  else
    LOGFILE="default.log"
fi

CUR_TIME=$(date +%D" "%r)

echo "${CUR_TIME} : ${SCRIPTNAME} ${INFO}" >> ${LOGPATH}/${LOGFILE}



