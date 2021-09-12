#!/bin/sh

mkdir out; cd out

${TAR_XF} ../archive.tar >/dev/null 2>&1
fp=$(grep -c "return 0" archive/main.c 2>/dev/null)
if [ "${fp}" = "1" ]
then
	echo "0"
else
	echo "1-${fp}"
fi
