LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := hello

LOCAL_SRC_FILES := $(call all-c-files-under, .)

LOCAL_CFLAGS :=

LOCAL_C_INCLUDES := include/h/

LOCAL_STATIC_LIBRARIES :=

LOCAL_SHARED_LIBRARIES :=

include $(BUILD_EXECUTABLE)

