#!/bin/bash
MY_PATH=`which $0  |xargs ls -l | sed -r "s/.* //g" | sed -r "s/.*->//g"`
MY=${MY_PATH%/*}
for dir in $@ ; do
	if [ -d $dir ]; then
	        find $dir -name *.class -type f | xargs rm -f
		find $dir -type d | xargs rmdir -p --ignore-fail-on-non-empty
	else
		if [ -e $dir ]; then
			echo warning cleanjavacoutput.sh ***: $dir is not a directory.
		fi
	fi
done

