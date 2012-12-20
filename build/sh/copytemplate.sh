#!/bin/bash
MY_PATH=`which $0  |xargs ls -l | sed -r "s/.* //g" | sed -r "s/.*->//g"`
MY=${MY_PATH%/*}

BUILD_FILE_NAME=`$MY/findconfig.sh MAKE_FILE_NAME`

if [ $2 ]; then
	MODULE_NAME=$2
else
	MODULE_NAME=$1_name
fi

if [ ! $BUILD_FILE_NAME ]; then
	echo "Can not local 'configure.mk' in current directory or it's parent directory."
	exit 1
fi

if [ -e $BUILD_FILE_NAME ]; then
	if [ -d $BUILD_FILE_NAME ]; then
		echo "Can not copy template. $BUILD_FILE_NAME exists as directory."
		exit -1;
	fi
	if [ -f $BUILD_FILE_NAME ]; then
		echo "Can not copy template. $BUILD_FILE_NAME already exists."
		exit -1;
	fi
fi

cat $MY/../templates/$1 $BUILD_FILE_NAME | sed -r "s/template_name/$MODULE_NAME/g" > $BUILD_FILE_NAME

cat $BUILD_FILE_NAME
