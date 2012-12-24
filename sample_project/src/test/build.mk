LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := testmake

LOCAL_SRC_FILES := $(call all-c-files-under, .)

LOCAL_CFLAGS :=

LOCAL_C_INCLUDES := include/test

LOCAL_STATIC_LIBRARIES := test_static

LOCAL_SHARED_LIBRARIES := libtest_dyna

include $(BUILD_EXECUTABLE)

