# specified the root dir of source code
TOP_DIR := $(shell pwd)

$(if $(BUILD_ROOT_DIR),, $(error No BUILD_ROOT_DIR specified in configure.mk))

include $(BUILD_ROOT_DIR)/configuration_check.mk

BUILT_LIBS :=
BUILT_BINS :=
BUILT_OBJS :=
BUILT_STATICS :=
BUILT_PREBUILTS :=
BUILT_SHORT_CUTS :=
BUILT_JAVA_CLASS_PATHES :=
BUILT_JAVA_BINS :=
BUILT_JAVA_LIBS :=

INSTALLED_LIBS :=
INSTALLED_BINS :=
INSTALLED_JAVA_LIBS :=
INSTALLED_JAVA_BINS :=
INSTALLED_PREBUILTS :=

ALL_MODULES :=

all: ${CONTENTS}
	${hide}echo Building Finished!

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
BUILD_JAVA_EXECUTABLE := ${BUILD_ROOT_DIR}/build_java_executable.mk
BUILD_JAVA_LIBRARY := ${BUILD_ROOT_DIR}/build_java_lib.mk

ifeq ($(ONE_SHOT_MAKEFILES),)
    ALL_MAKE_FILES := $(call all-named-files-under, $(TOP_DIR), $(MAKE_FILE_NAME))
    include $(ALL_MAKE_FILES)
else
    include $(ONE_SHOT_MAKEFILES)
endif


include ${BUILD_ROOT_DIR}/basic_rules.mk
