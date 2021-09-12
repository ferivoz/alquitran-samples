#!/bin/sh
#
# Process crafted tar archives with a tar program.
#
# Set environment variables to change implementation. Examples:
#
# busybox:    TAR="busybox tar"
# libarchive: TAR="bsdtar"
# pax:        TAR="pax" TAR_TF="pax -f" TAR_XF="pax -rf"
# p7zip:      TAR="7za" TAR_TF="7za l" TAR_XF="7za -y x"
# star:       TAR="star"

set -e

export TAR="${TAR:-tar}"
export TAR_TF="${TAR_TF:-${TAR} tf}"
export TAR_XF="${TAR_XF:-${TAR} xf}"

cleanup() {
	for out in *_*/out
	do
		rm -rf "${out}"
	done
}

cleanup
echo "{"

unset last
for script in *_*/check.sh
do
	dir=$(dirname ${script})
	fp=$(cd "${dir}"; ./check.sh)
	if [ -n "${last}" ]
	then
		echo "${last},"
	fi
	last="  \"${dir#samples/}\": \"${fp}\""
done
if [ -n "${last}" ]
then
	echo "${last}"
fi

echo "}"
cleanup
