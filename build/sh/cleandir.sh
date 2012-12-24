#!/bin/bash
for dir in $@ ; do
	# Don't delete soft link. Althrogh the commented code can safely delete
	# the soft link of an empty directory. But I still think recreating a
        # soft link is far too 'difficult' than recreating a soft link. So, keep
	# the soft link.
	if [ -h $dir ]; then
		continue
		#if [ ! "`ls -A $dir`" ]; then
		#	rm $dir
		#fi
	fi

	if [ -d $dir ]; then
		rmdir -p --ignore-fail-on-non-empty $dir >/dev/null 2>&1
	fi
done
