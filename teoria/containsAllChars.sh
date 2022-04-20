#!/bin/sh

if [ $# -ne 2 ]
then
	echo "Missing arguments" >&2
	echo "USAGE: $0 <String1> <String2>" >&2
	exit 1
fi

src=$2
len=$(expr length $2)
idx='0'

while [ $idx -le $len ]
do
	if !(echo $1 | grep "${src:(($idx - 1)):$idx}") >/dev/null
	then
		exit 1
	fi
	idx=$(($idx + 1))
done
exit 0
