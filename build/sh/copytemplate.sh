#!/bin/bash
MY_PATH=`which $0  |xargs ls -l | sed -r "s/.* //g" | sed -r "s/.*->//g"`
MY=${MY_PATH%/*}

BUILD_FILE_NAME=`$MY/findconfig.sh MAKE_FILE_NAME`

if [ ! $1 ]; then
	echo Must specified a template file name.
	exit -1
fi

if [ $2 ]; then
	MODULE_NAME=$@
else
	MODULE_NAME[0]=$1
	MODULE_NAME[1]=default_module_name
fi

FILTER_COMMENTS='{strings never comes with a template}'

for args in $@; do
	if [ $args == "-c" ];then
		FILTER_COMMENTS='#'
		break;
	fi
done

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


cat $MY/../templates/common_header | grep -v "$FILTER_COMMENTS" > $BUILD_FILE_NAME


let i=0
for module_name in $MODULE_NAME; do
	let i=$i+1
	if [ $i -eq 1 ]; then continue ;fi # skip template name
	if [ $module_name == "-c" ]; then continue; fi # skip args
	cat $MY/../templates/$1 | sed -r "s/template_name/$module_name/g" | grep -v "$FILTER_COMMENTS" >> $BUILD_FILE_NAME
	cat $MY/../templates/module_seperator >> $BUILD_FILE_NAME
done

cat $BUILD_FILE_NAME
