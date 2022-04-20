#!/bin/sh

if [ $# -ne 1 ] 
then
	echo "Missing arguments" >&2
	echo "USAGE: $0 <String>" >&2
	exit 1
fi

src=$1
len=$(expr length $1)
idx='1'
out=""

while [ $idx -le $len ]
do
	out="$out ${src:(($idx - 1)):$idx}"
	idx=$(($idx + 1))
done
echo $out
exit 0
