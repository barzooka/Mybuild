LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := test_static

LOCAL_SRC_FILES := $(call all-c-files-under, .)

LOCAL_CFLAGS :=

LOCAL_C_INCLUDES :=

include $(BUILD_STATIC_LIBRARY)

