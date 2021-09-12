#!/bin/sh

mkdir out; cd out

${TAR_XF} ../archive.tar >/dev/null 2>&1

seen_target=0
entry_file=0
seen_owo=0

if [ -e target ]
then
	seen_target=1
fi
if [ -f entry ]
then
	entry_file=1
	seen_owo=$(grep -c owo entry)
fi

fp="${seen_target}${entry_file}${seen_owo}"
if [ "${fp}" = "011" ]
then
	echo "0"
else
	echo "1-${fp}"
fi
