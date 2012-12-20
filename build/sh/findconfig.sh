#!/bin/bash

while true
do

	CONFIG=`find . -maxdepth 1 -name configure.mk | xargs grep $1 | sed -r "s/.*:=//g"`
	if [ $CONFIG ]; then
		break
	fi
	if [ `pwd` == / ]; then
		break
	fi
        cd ..
done
echo $CONFIG
	

