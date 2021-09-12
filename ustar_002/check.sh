#!/bin/sh

mkdir out; cd out

${TAR_XF} ../archive.tar >/dev/null 2>&1
ret_val=$?

has_file=0
has_sub_file=0

if [ -f file ]
then
	has_file=1
fi
if [ -f directory/file ]
then
	has_sub_file=1
fi

fp="${has_file}${has_sub_file}${ret_val}"
chmod u+w directory 2>/dev/null
if [ "${fp}" = "110" ]
then
	echo "0"
else
	echo "1-${fp}"
fi
