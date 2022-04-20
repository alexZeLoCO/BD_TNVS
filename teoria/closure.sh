#!/bin/sh

if [ $# -ne 2 ]
then
	echo "ERR. Missing args"   >&2
	echo "USAGE: $0 <R> <F>"   >&2
	echo 'R="A D" F="A>B B>C"' >&2
	exit 1
fi

# $1 = R ==> A B C D
# $2 = F ==> A>B B>C

out=$1
prev=" "

while [ "$out" != "$prev" ] # Until there are no changes
do
	prev=$out
	for i in $2 # For each condition>consequence
	do
		if (./containsAllChars.sh "$out" "$(echo $i | cut -d '>' -f 1)") # Check if condition is met
		then
			if !(./containsAllChars.sh "$out" "$(echo $i | cut -d '>' -f 2)") # Check if consequence is not new
			then
				out="$out $(./spaceOut.sh $(echo $i | cut -d '>' -f 2))" # Add consecuence
			fi
		fi
	done
done	
echo "$out"
exit 0
