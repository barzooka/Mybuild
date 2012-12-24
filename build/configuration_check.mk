
# No need to check BUILD_ROOT_DIR in this file. It should have been checked in core.mk

$(if $(MAKE_FILE_NAME),,$(error No MAKE_FILE_NAME specified in configure.mk))

ifeq ($(BUILD_SHORTCUT_DIR),)
BUILD_SHORTCUT_DIR := .
else
BUILD_SHORTCUT_DIR := $(patsubst %/,%,$(BUILD_SHORTCUT_DIR))
endif

ifeq ($(BUILD_OUT_DIR),)
BUILD_OUT_DIR := out 
endif

ifeq ($(BUILD_OBJ_DIR),)
BUILD_OBJ_DIR := $(BUILD_OUT_DIR)/obj
endif

ifeq ($(BUILD_BIN_DIR),)
BUILD_BIN_DIR := $(BUILD_OUT_DIR)/bin
endif

ifeq ($(BUILD_LIB_DIR),)
BUILD_LIB_DIR := $(BUILD_OUT_DIR)/lib
endif

ifeq ($(CONTENTS),)
CONTENTS := hello-build-system
endif

ifeq ($(INSTALLED_BIN_DIR),)
INSTALL_BIN_DIR := ~/bin
endif

ifeq ($(INSTALL_LIB_DIR),)
INSTALL_LIB_DIR := /usr/lib
endif


