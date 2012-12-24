#########################################################################
#     Mybuild make file for modules
#
#     The basic rule of this file is the same with Android build system.
#     A typical format of this file is:
#
#     LOCAL_DIR := $(call my-dir)
#
#     include $(CLEAR_VARS)
#     LOCAL_MODULE := module1
#     # Set other variables
#     include $(BUILD_XXXXX) # where XXXXX is the type of this module
#
#     include $(CLEAR_VARS)
#     LOCAL_MODULE := module2
#     # Set other variables
#     include $(BUILD_XXXXX) # where XXXXX is the type of this module
#
#     # module3 module4 ....
#-----------------------------------------------------------------------

# LOCAL_PATH indicates where your source code are
LOCAL_PATH := $(call my-dir)

# $(CLEAR_VARS) must be included at the begining of the file.
# DON'T call '$(call my-dir)' after 'include $(CLEAR_VARS)' and any other make files
include $(CLEAR_VARS)

# Specify the name of this module.
LOCAL_MODULE := class1

# Source files list
LOCAL_SRC_FILES := $(call all-java-files-under, .)

# Dependent java libraries. NOTE: The modules built as JAVA_EXECUTABLES can also present here
LOCAL_JAVA_LIBRARIES := class3

# Specify the class with a public static void main as the defailt entry of the program.
# The make system will use the first class containing that method if you leaving this variable as empty
LOCAL_JAVA_MAIN_ENTRY := com.barzooka.pack1.Class1

# Include the make file which solves the variables above, and generate the rules for this module
include $(BUILD_JAVA_EXECUTABLE)
#---------------------------------------------------------
