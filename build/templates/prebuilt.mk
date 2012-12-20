LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(call all-files-and-dirs-under, .)

LOCAL_MODULE_PATH := $(BUILD_OUT_DIR)/prebuilt

LOCAL_MODULE := template_name

# This LOCAL_PREBUILT_TYPE must be set to 'build' or 'install'.
LOCAL_PREBUILT_TYPE :=

include $(BUILD_PREBUILT)

