# alquitran-samples

Each subdirectory contains an archive file which highlights how tar
implementations differ in their way of interpreting specific conditions
in tar formats.

The goal is to show why specific paradigms should not be used for best
portability and how to avoid undefined behavior in regard to POSIX 2017.

# Usage

Run `check.sh` as regular user to inspect your tar implementation with
all gathered samples. The script output is JSON formatted and contains
results for each sample. If your tar implementation interprets the
archive file correctly, then the value starts with a 0. If the value
starts with a 1, then your implementation possibly misbehaves or another
condition leads to test case errors.

# Samples

Subdirectory names start with the format they implement, e.g. ustar. The
suffix is simply an incremented index number based on time of addition
to this collection.

The ustar format is specified by POSIX 2017. It is the preferred format
for samples. Test cases use other formats only if they are required.

## ustar\_001 (invalid number format)

Numbers in fields shall have leading zeros and terminating nul or space
characters. Some other tar formats allow leading spaces. Test how an
implementation reacts to space formatted numbers, numbers missing
terminating nul or space characters, and illegal number fields.

Strict implementations should discard contained header, but discarding
the header might lead to a bad user experience. This conflict already
explains why this test case easily leads to different results.

Conclusion: Number fields must start with a number and terminate.

## ustar\_002 (read-only directory)

If a read-only directory contains files, then tar implementations have
to keep this in mind. The mode can only be set after all contained files
and directories have been created. Some implementations fail to extract
such archives.

Conclusion: Read-only directories reduce portability.

## ustar\_003 (regular files with empty name and empty prefix)

A regular file entry without a name would lead to a file with an illegal
file name. POSIX 2017 states that the processing of such entries is
implementation-defined. Two consecutive empty name entries can be
misinterpreted as two consecutive empty blocks (end of archive) by
implementations.

Conclusion: Entries must have names with portable characters.

## ustar\_004 (regular file replaces symbolic link)

Directory traversing links can lead to security issues, e.g. extracting
entries which have such links in their parent path. Some implementations
replace such symbolic links temporarily with files and set actual links
after extraction. If such a temporary file is replaced with an actual
file during extraction, then the actual file should remain.

Conclusion: Multiple entries with same path reduce portability.

## v7\_001 (directory with size)

Directories in v7 tar archives must end with a slash. Also they may have
a size but do not have attached data blocks. This crafted archive
contains two versions of a file. Which version is extracted depends on
correctness of the tar implementation.

Conclusion: Directories with a size reduce portability.
