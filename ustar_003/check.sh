#!/bin/sh

mkdir out; cd out

${TAR_TF} ../archive.tar > index.txt 2>/dev/null
seen_owo=$(grep -c owo index.txt)
seen_uwu=$(grep -c uwu index.txt)
${TAR_XF} ../archive.tar >/dev/null 2>&1

has_owo=0
has_uwu=0

if [ -f owo ]
then
	has_owo=1
fi
if [ -f uwu ]
then
	has_uwu=1
fi

fp="${seen_owo}${seen_uwu}${has_owo}${has_uwu}"
if [ "${fp}" = "1111" ]
then
	echo "0"
else
	echo "1-${fp}"
fi
