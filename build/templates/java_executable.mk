# $(CLEAR_VARS) must be included at the begining of the file.
# DON'T call '$(call my-dir)' after 'include $(CLEAR_VARS)' and any other make files
include $(CLEAR_VARS)

# Specify the name of this module.
LOCAL_MODULE := template_name

# Source files list
LOCAL_SRC_FILES := $(call all-java-files-under, .)

# Dependent java libraries. NOTE: The modules built as JAVA_EXECUTABLES can also present here
LOCAL_JAVA_LIBRARIES :=

# Specify the class with a public static void main as the defailt entry of the program.
# The make system will use the first class containing that method if you leaving this variable as empty
LOCAL_JAVA_MAIN_ENTRY := 

# Include the make file which solves the variables above, and generate the rules for this module
include $(BUILD_JAVA_EXECUTABLE)
