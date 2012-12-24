# Tools
CC := g++
AR := ar

# Where stores the build system
BUILD_ROOT_DIR := build

# Where do we place the build result
BUILD_OUT_DIR := out
BUILD_OBJ_DIR := $(BUILD_OUT_DIR)/obj
BUILD_BIN_DIR := $(BUILD_OUT_DIR)/bin
BUILD_LIB_DIR := $(BUILD_OUT_DIR)/lib

# Specify the makefile name used to build a certain module
MAKE_FILE_NAME := build.mk

# Wether print the commands executed by make
PRINT_COMMANDS := true

# C flags used to build all the c/c++ files
GLOBAL_CFLAGS := -g

# Specify the main module of this project.
CONTENTS := testmake

# where to install the executable files
INSTALL_BIN_DIR := ~/bin

# where to install the shared libraries
INSTALL_LIB_DIR := /usr/lib
