BUILT_RESULT := ${BUILT_BINS} \
                ${BUILT_OBJS} \
                ${BUILT_LIBS} \
                ${BUILT_STATICS} \
                ${BUILT_PREBUILTS} \
                ${BUILT_SHORT_CUTS} \
                ${BUILT_JAVA}

ifeq ($(BUILT_RESULT),)
    ifeq ($(BUILT_JAVA_CLASS_PATHES),)
        CLEAN_IF :=
    else
        CLEAN_IF := clean_all
    endif
else
    CLEAN_IF := clean_all
endif

ifeq ($(BUILT_BINS),)
INSTALL_BINS_IF :=
UNINSTALL_BINS_IF :=
else
INSTALL_BINS_IF := install_bins
UNINSTALL_BINS_IF := uninstall_bins
endif

ifeq ($(BUILT_LIBS),)
INSTALL_LIBS_IF :=
UNINSTALL_LIBS_IF :=
else
INSTALL_LIBS_IF := install_libs
UNINSTALL_LIBS_IF := uninstall_libs
endif

ifeq ($(BUILT_JAVA),)
INSTALL_JAVA_IF :=
UNINSTALL_JAVA_IF :=
else
INSTALL_JAVA_IF := install_jars
UNINSTALL_JAVA_IF := uninstall_jars
endif

ifeq ($(INSTALLED_PREBUILTS),)
UNINSTALL_PREBUILTS_IF :=
else
UNINSTALL_PREBUILTS_IF := uninstall_prebuilts
endif

clean: $(CLEAN_IF)
	${hide}echo Clean finished!

clean_all:
	${hide}$(BUILD_ROOT_DIR)/sh/cleanjavacoutput.sh $(BUILT_JAVA_CLASS_PATHES)
	${hide}rm $(BUILT_RESULT) -rf
	${hide}$(BUILD_ROOT_DIR)/sh/cleandir.sh $(dir $(BUILT_RESULT)) $(BUILT_JAVA_CLASS_PATHES)

hello-build-system:
	${hide}echo =======================================================================
	${hide}echo My Build System version 1.0.0
	${hide}echo
	${hide}echo To start, add a build target name in CONTENTS variable in configure.mk.
	${hide}echo =======================================================================

install: $(INSTALL_LIBS_IF) $(INSTALL_BINS_IF) $(INSTALLED_PREBUILTS) $(INSTALL_JAVA_IF)

uninstall: $(UNINSTALL_LIBS_IF) $(UNINSTALL_BINS_IF) $(UNINSTALL_PREBUILTS_IF) $(UNINSTALL_JAVA_IF)

info: $(addsuffix _debug, $(ALL_MODULES))
	$(hide)echo =========================
	$(hide)echo For GLOBAL:
	$(hide)echo TOP_DIR          : $(TOP_DIR)
	$(hide)echo BUILD_ROOT_DIR   : $(BUILD_ROOT_DIR)
	$(hide)echo ALL_MODULES      : $(ALL_MODULES)
	$(hide)echo MODULES_COUNT    : $(words $(ALL_MODULES))
	$(hide)echo BUILT_BINS       : $(BUILT_BINS)
	$(hide)echo BUILT_LIBS       : $(BUILT_LIBS)
	$(hide)echo BUILT_STATICS    : $(BUILT_STATICS)
	$(hide)echo BUILT_OBJS       : $(BUILT_OBJS)
	$(hide)echo BUILT_PREBUILTS  : $(BUILT_PREBUILTS)
	$(hide)echo INSTALLED_PREBUILTS : $(INSTALLED_PREBUILTS)
	$(hide)echo INSTALL_BIN_DIR  : $(INSTALL_BIN_DIR)
	$(hide)echo INSTALL_LIB_DIR  : $(INSTALL_LIB_DIR)
	$(hide)echo -------------------------

install_bins: $(BUILT_BINS)
	$(hide)mkdir -p $(INSTALL_BIN_DIR)
	$(hide)echo "INSTALLING EXECUTABLE(s) TO:" $(INSTALL_BIN_DIR):
	$(hide)echo $(BUILT_BINS)
	$(hide)cp $(BUILT_BINS) $(INSTALL_BIN_DIR)

install_libs: $(BUILT_LIBS)
	$(hide)mkdir -p $(INSTALL_LIB_DIR)
	$(hide)echo "INSTALLING SHARED LIBRARY(ies) TO:" $(INSTALL_LIB_DIR):
	$(hide)echo $(BUILT_LIBS)
	$(hide)cp $(BUILT_LIBS) $(INSTALL_LIB_DIR)

install_jars: $(BUILT_JAVA)
	$(hide)mkdir -p $(INSTALL_JAVA_DIR)
	$(hide)echo "INSTALLING JAVA JAR(s) TO:" $(INSTALL_JAVA_DIR):
	$(hide)echo $(BUILT_JAVA)
	$(hide)cp $(BUILT_JAVA) $(INSTALL_JAVA_DIR)

uninstall_libs:
	$(hide)echo "REMOVING SHARED LIBRARY(ies):"  $(patsubst $(BUILD_LIB_DIR)%, $(INSTALL_LIB_DIR)%,$(BUILT_LIBS))
	$(hide)rm $(patsubst $(BUILD_LIB_DIR)%, $(INSTALL_LIB_DIR)%,$(BUILT_LIBS)) -rf
	$(hide)$(BUILD_ROOT_DIR)/sh/cleandir.sh $(INSTALL_LIB_DIR)

uninstall_bins:
	$(hide)echo "REMOVING EXECUTABLE(s):"  $(patsubst $(BUILD_BIN_DIR)%, $(INSTALL_BIN_DIR)%,$(BUILT_BINS))
	$(hide)rm $(patsubst $(BUILD_BIN_DIR)%, $(INSTALL_BIN_DIR)%,$(BUILT_BINS)) -rf
	$(hide)$(BUILD_ROOT_DIR)/sh/cleandir.sh $(INSTALL_BIN_DIR)

uninstall_jars:
	$(hide)echo "REMOVEING JAVA JARS(s):" $(patsubst $(BUILD_JAVA_DIR)%, $(INSTALL_JAVA_DIR)%,$(BUILT_JAVA))
	$(hide)rm  $(patsubst $(BUILD_JAVA_DIR)%, $(INSTALL_JAVA_DIR)%,$(BUILT_JAVA)) -rf
	$(hide)$(BUILD_ROOT_DIR)/sh/cleandir.sh $(INSTALL_JAVA_DIR)

uninstall_prebuilts:
	$(hide)rm $(INSTALLED_PREBUILTS) -rf
	$(hide)$(hide)$(BUILD_ROOT_DIR)/sh/cleandir.sh $(dir $(INSTALLED_PREBUILTS))

all_modules: $(ALL_MODULES)
	$(hide)echo Building Finished!
