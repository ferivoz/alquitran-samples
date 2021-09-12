#!/bin/sh

mkdir out; cd out

${TAR_XF} ../archive.tar >/dev/null 2>&1
ret_val=$?
if [ ${ret_val} -ne 0 ]
then
	ret_val=1
fi

has_owo=0
if [ -f owo ]
then
	has_owo=1
fi

fp="${has_owo}${ret_val}"
if [ "${fp}" = "01" ]
then
	echo "0"
else
	echo "1-${fp}"
fi
