#!/bin/bash
for dir in $@ ; do
	if [ -d $dir ]; then
		rmdir -p --ignore-fail-on-non-empty $dir
	fi
done
