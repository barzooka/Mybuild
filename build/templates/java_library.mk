# $(CLEAR_VARS) must be included at the begining of the file.
# DON'T call '$(call my-dir)' after 'include $(CLEAR_VARS)' and any other make files
include $(CLEAR_VARS)

# Specify the name of this module.
LOCAL_MODULE := template_name

# Source files list
LOCAL_SRC_FILES := $(call all-java-files-under, .)

# Dependent java libraries. NOTE: The modules built as JAVA_EXECUTABLES can also present here
LOCAL_JAVA_LIBRARIES :=

# Include the make file which solves the variables above, and generate the rules for this module
include $(BUILD_JAVA_LIBRARY)

