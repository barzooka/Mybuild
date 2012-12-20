define source-to-o
$(patsubst %.c, %.o, $(patsubst %.cpp, %.o, $(patsubst %.cc, %.o, $(patsubst %.s, %.o, $(patsubst %.S, %.o, $(1))))))
endef

define static-full-path
$(addprefix $(BUILD_OBJ_DIR)/, $(addsuffix .a, $(1)))
endef

define dynamic-full-path
$(addprefix $(BUILD_LIB_DIR)/, $(addsuffix .so, $(1)))
endef

define executable-full-path
$(addprefix $(BUILD_BIN_DIR)/, $(1))
endef

define prebuilt-full-path
$(addprefix $(LOCAL_MODULE_PATH)/, $(patsubst $(LOCAL_PATH)/%, %, $(1)))
endef

define all-java-files-under
$(patsubst ./%,%, \
  $(shell cd $(LOCAL_PATH); find $(1) -name "*.java" -and -not -name ".*" -type f) \
 )
endef

define all-c-files-under
$(patsubst ./%,%, \
  $(shell cd $(LOCAL_PATH); find $(1) -name "*.cpp" -o -name "*.c" -o -name "*.cc" -and -not -name ".*" -type f) \
 )
endef

define all-files-and-dirs-under
$(patsubst %$(MAKE_FILE_NAME),, $(patsubst $(1),, $(patsubst ./%,%, \
  $(shell cd $(LOCAL_PATH); find $(1) -maxdepth 1) \
      )\
   )\
)
endef

define all-c-files-under-non-recursive
$(patsubst ./%,%, \
  $(shell cd $(LOCAL_PATH); find $(1) -name "*.cpp" -o -name "*.c" -o -name "*.cc" -and -not -name ".*" -type f -maxdepth 1) \
 )
endef

define all-named-files-under
$(patsubst ./%,%, \
  $(shell cd $(LOCAL_PATH); find $(1) -name $(2) -type f) \
 )
endef

define my-dir
$(strip $(patsubst %/, %, $(patsubst /%, %, $(patsubst $(TOP_DIR)%, %, $(strip \
  $(eval LOCAL_MODULE_MAKEFILE := $$(lastword $$(MAKEFILE_LIST))) \
    $(if $(filter $(CLEAR_VARS),$(LOCAL_MODULE_MAKEFILE)), \
        $(error LOCAL_PATH must be set before including $$(CLEAR_VARS)) \
   , \
       $(dir $(LOCAL_MODULE_MAKEFILE)) \
          ) \
     ) \
  ) \
 ) \
)\
)
endef

define prepare-args
# Add includes into LOCAL_CFLAGS
LOCAL_CFLAGS += $(addprefix -I, $(patsubst ./%, $(LOCAL_PATH)/%, $(LOCAL_C_INCLUDES)))
# Adjust path for source files
ifneq ($(LOCAL_PATH),)
LOCAL_SRC_FILES := $(strip $(addprefix $(LOCAL_PATH)/, $(LOCAL_SRC_FILES)))
endif
LOCAL_LD_ARGS := $(addprefix -l, $(patsubst lib%, %, $(LOCAL_SHARED_LIBRARIES)))
LOCAL_LD_ARGS += -L$(BUILD_LIB_DIR)
endef

define start-build-action
$(if $(filter included, $(BUILD_ACTION_INCLUDED)), \
    $(error For MODULE $(LOCAL_MODULE), $(BUILD_ACTION_INCLUDED) ONLY ONE BUILD ACTION ALLOWD after CLEAR_VARS) \
)
BUILD_ACTION_INCLUDED := included
LOCAL_MODULE_TYPE := $(1)
endef

define prepare-translate-c-o
OBJ := $(patsubst ./%,%, $(addprefix $(BUILD_OBJ_DIR)/, $(call source-to-o, $(1))))
DIR = $$(dir $$(OBJ))
endef

define translate-c-o
LOCAL_OBJ_FILES += $(OBJ)
BUILT_OBJS += $(OBJ)
$(OBJ): $(1)
	${hide}echo $(LOCAL_MODULE_TYPE) ${CC}: $(LOCAL_MODULE) '<=' $(1)
	${hide}mkdir -p $(DIR)
	${hide}$(CC) $(GLOBAL_CFLAGS) $(LOCAL_CFLAGS) -c $(1) -o $(OBJ)
endef

define build-executable
ALL_MODULES += $(LOCAL_MODULE)
BUILT_BINS += $(call executable-full-path, $(LOCAL_MODULE))

$(LOCAL_MODULE): $(call executable-full-path, $(LOCAL_MODULE))
	

$(call executable-full-path, $(LOCAL_MODULE)): $$(call static-full-path, $$(LOCAL_STATIC_LIBRARIES)) $$(call dynamic-full-path, $$(LOCAL_SHARED_LIBRARIES)) $(LOCAL_OBJ_FILES)
	${hide}mkdir -p $(BUILD_BIN_DIR)
	${hide}$(CC) $(LOCAL_OBJ_FILES) $(call static-full-path, $(LOCAL_STATIC_LIBRARIES)) $(LOCAL_LD_ARGS) -o $(BUILD_BIN_DIR)/$(LOCAL_MODULE)
	${hide}echo $(LOCAL_MODULE_TYPE) Finished: $(call executable-full-path, $(LOCAL_MODULE))

$(eval $(call build-debug))
endef

define build-dynamic
ALL_MODULES += $(LOCAL_MODULE)
BUILT_LIBS += $(call dynamic-full-path, $(LOCAL_MODULE))
$(LOCAL_MODULE): $(call dynamic-full-path, $(LOCAL_MODULE))
	

$(call dynamic-full-path, $(LOCAL_MODULE)): $$(call static-full-path, $$(LOCAL_STATIC_LIBRARIES)) $$(call dynamic-full-path, $$(LOCAL_SHARED_LIBRARIES)) $(LOCAL_OBJ_FILES)
	${hide}mkdir -p $(BUILD_LIB_DIR)
	${hide}$(CC) $(LOCAL_OBJ_FILES) $(call static-full-path, $(LOCAL_STATIC_LIBRARIES)) $(LOCAL_LD_ARGS) -shared -o $(BUILD_LIB_DIR)/$(LOCAL_MODULE).so
	${hide}echo $(LOCAL_MODULE_TYPE) Finished: $(call dynamic-full-path, $(LOCAL_MODULE))

$(eval $(call build-debug))
endef

define build-static
ALL_MODULES += $(LOCAL_MODULE)
BUILT_STATICS += $(call static-full-path, $(LOCAL_MODULE))
$(LOCAL_MODULE): $(call static-full-path, $(LOCAL_MODULE))
	

$(call static-full-path, $(LOCAL_MODULE)): $(LOCAL_OBJ_FILES)
	${hide}mkdir -p $(BUILD_OBJ_DIR)
	${hide}$(AR) rcs $(BUILD_OBJ_DIR)/$(LOCAL_MODULE).a $(LOCAL_OBJ_FILES)
	${hide}echo $(LOCAL_MODULE_TYPE) Finished: $(call static-full-path, $(LOCAL_MODULE))

$(eval $(call build-debug))
endef

define cp-single-file
$(2): $(1)
	${hide}mkdir -p $(dir $(2))
	${hide}cp $(1) $(2) -r
endef

define build-prebuilt
ALL_MODULES += $(LOCAL_MODULE)

$(if $(filter build, $(LOCAL_PREBUILT_TYPE)), \
    $(eval BUILT_PREBUILTS += $(call prebuilt-full-path, $(LOCAL_SRC_FILES))) \
)

$(if $(filter install, $(LOCAL_PREBUILT_TYPE)), \
    $(eval INSTALLED_PREBUILTS += $(call prebuilt-full-path, $(LOCAL_SRC_FILES))) \
)

$(LOCAL_MODULE): $(call prebuilt-full-path, $(LOCAL_SRC_FILES))
	${hide}echo $(LOCAL_MODULE_TYPE) $(LOCAL_PREBUILT_TYPE) Finished: $(LOCAL_MODULE)

$(foreach src, $(LOCAL_SRC_FILES), \
    $(eval $(call cp-single-file, $(src), \
        $(call prebuilt-full-path, $(src))) \
    ) \
)

$(eval $(call build-debug))
endef

define build-debug
$(LOCAL_MODULE)_debug:
	${hide}echo ===================================
	${hide}echo For LOCAL_MODULE       : $(LOCAL_MODULE) "($(LOCAL_MODULE_TYPE))"
	${hide}echo LOCAL_PATH             : $(LOCAL_PATH)
	${hide}echo LOCAL_SRC_FILES        : $(LOCAL_SRC_FILES)
	${hide}echo LOCAL_OBJ_FILES        : $(LOCAL_OBJ_FILES)
	${hide}echo LOCAL_CFLAGS           : $(LOCAL_CFLAGS)
	${hide}echo LOCAL_SHARED_LIBRARIES : $(LOCAL_SHARED_LIBRARIES)
	${hide}echo LOCAL_STATIC_LIBRARIES : $(LOCAL_STATIC_LIBRARIES)
	${hide}echo LOCAL_C_INCLUDES       : $(LOCAL_C_INCLUDES)
	${hide}echo LOCAL_LD_ARGS          : $(LOCAL_LD_ARGS)
	${hide}echo LOCAL_MODULE_PATH      : $(LOCAL_MODULE_PATH)
	${hide}echo LOCAL_PREBUILT_TYPE    : $(LOCAL_PREBUILT_TYPE)
	${hide}echo -----------------------------------
endef

