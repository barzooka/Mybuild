# specified the root dir of source code
TOP_DIR := $(shell pwd)

BUILT_LIBS :=
BUILT_BINS :=
BUILT_OBJS :=
BUILT_STATICS :=
BUILT_PREBUILTS :=

INSTALLED_LIBS :=
INSTALLED_BINS :=

INSTALLED_PREBUILTS :=

ALL_MODULES :=

include configure.mk

all: ${CONTENTS}
	${hide}echo Build Finished!

ifeq ($(PRINT_COMMANDS), true)
hide := 
else
hide := @
endif

# include function definitions
include ${BUILD_ROOT_DIR}/functions.mk

CLEAR_VARS := ${BUILD_ROOT_DIR}/clear_vars.mk
BUILD_EXECUTABLE := ${BUILD_ROOT_DIR}/build_executable.mk
BUILD_OBJECTS := ${BUILD_ROOT_DIR}/build_objects.mk
BUILD_STATIC_LIBRARY := ${BUILD_ROOT_DIR}/build_static.mk
BUILD_SHARED_LIBRARY := ${BUILD_ROOT_DIR}/build_dynamic.mk
BUILD_PREBUILT := ${BUILD_ROOT_DIR}/build_prebuilt.mk

ALL_MAKE_FILES := $(call all-named-files-under, $(TOP_DIR), $(MAKE_FILE_NAME))
include $(ALL_MAKE_FILES)


include ${BUILD_ROOT_DIR}/basic_rules.mk
