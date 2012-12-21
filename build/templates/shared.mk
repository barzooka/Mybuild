# LOCAL_PATH indicates where your source code are
LOCAL_PATH := $(call my-dir)

# $(CLEAR_VARS) must be included at the begining of the file.
# DON'T call '$(call my-dir)' after 'include $(CLEAR_VARS)' and any other make files
include $(CLEAR_VARS)

# Specify the name of this module.
LOCAL_MODULE := template_name

# Source files list
LOCAL_SRC_FILES := $(call all-c-files-under, .)

# Tell the compiler where can it find the include filse
LOCAL_C_INCLUDES :=

# Arguments that will be passed to the compiler while building this module
LOCAL_CFLAGS :=

# Specify the module names of the static libraries needed by this module.
LOCAL_STATIC_LIBRARIES :=

# Specify the module names of the shared libraries needed by this module.
LOCAL_SHARED_LIBRARIES :=

# Include the make file which solves the variables above, and generate the rules for this module
include $(BUILD_SHARED_LIBRARY)

