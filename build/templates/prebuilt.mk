# $(CLEAR_VARS) must be included at the begining of the file.
# DON'T call '$(call my-dir)' after 'include $(CLEAR_VARS)' and any other make files
include $(CLEAR_VARS)

# Specify the name of this module.
LOCAL_MODULE := template_name

# Source files list which will be copied
LOCAL_SRC_FILES := $(call all-files-and-dirs-under, .)

# Specify the target directory
LOCAL_MODULE_PATH := $(BUILD_OUT_DIR)/prebuilt

# This LOCAL_PREBUILT_TYPE must be set to 'build' or 'install'.
# For 'build', means the files will be copied while compilation, and the copied files
#      will be removed when 'make clean'
#
# For 'install', means the files will be copied when you execute 'make install', and
#      the copied files will be removed when 'make install'
LOCAL_PREBUILT_TYPE :=

include $(BUILD_PREBUILT)

