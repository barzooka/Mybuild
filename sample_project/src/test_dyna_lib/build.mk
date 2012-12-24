LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libtest_dyna

LOCAL_SRC_FILES := $(call all-c-files-under, .)

LOCAL_CFLAGS :=

LOCAL_C_INCLUDES :=

LOCAL_STATIC_LIBRARIES :=

LOCAL_SHARED_LIBRARIES :=

include $(BUILD_SHARED_LIBRARY)

