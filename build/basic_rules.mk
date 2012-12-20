clean:
	${hide}rm ${BUILT_BINS} ${BUILT_OBJS} ${BUILT_LIBS} ${BUILT_STATICS} -rf
	${hide}$(BUILD_ROOT_DIR)/sh/cleandir.sh $(dir $(BUILT_BINS)) $(dir $(BUILT_OBJS)) $(dir $(BUILT_LIBS)) $(dir $(BUILT_STATICS))

hello-build-system:
	${hide}echo =======================================================================
	${hide}echo My Build System version 1.0.0
	${hide}echo
	${hide}echo To start, add a build target name in CONTENTS variable in configure.mk.
	${hide}echo =======================================================================

ifeq ($(BUILT_BINS),)
INSTALL_BINS_IF =
UNINSTALL_BINS_IF =
else
INSTALL_BINS_IF = install_bins
UNINSTALL_BINS_IF = uninstall_bins
endif

ifeq ($(BUILT_LIBS),)
INSTALL_LIBS_IF =
UNINSTALL_LIBS_IF =
else
INSTALL_LIBS_IF = install_libs
UNINSTALL_LIBS_IF = uninstall_libs
endif

install: $(INSTALL_LIBS_IF) $(INSTALL_BINS_IF)

uninstall: $(UNINSTALL_LIBS_IF) $(UNINSTALL_BINS_IF)

info: $(addsuffix _debug, $(ALL_MODULES))
	$(hide)echo =========================
	$(hide)echo For global:
	$(hide)echo TOP_DIR          : $(TOP_DIR)
	$(hide)echo BUILD_ROOT_DIR   : $(BUILD_ROOT_DIR)
	$(hide)echo ALL_MODULES      : $(ALL_MODULES)
	$(hide)echo MODULES_COUNT    : $(words $(ALL_MODULES))
	$(hide)echo BUILT_BINS       : $(BUILT_BINS)
	$(hide)echo BUILT_LIBS       : $(BUILT_LIBS)
	$(hide)echo BUILT_STATICS    : $(BUILT_STATICS)
	$(hide)echo BUILT_OBJS       : $(BUILT_OBJS)
	$(hide)echo INSTALL_BIN_DIR  : $(INSTALL_BIN_DIR)
	$(hide)echo INSTALL_LIB_DIR  : $(INSTALL_LIB_DIR)
	$(hide)echo -------------------------


install_bins: $(BUILT_BINS)
	$(hide)mkdir -p $(INSTALL_BIN_DIR)
	$(hide)cp $(BUILT_BINS) $(INSTALL_BIN_DIR)

install_libs: $(BUILT_LIBS)
	$(hide)mkdir -p $(INSTALL_LIB_DIR)
	$(hide)cp $(BUILT_LIBS) $(INSTALL_LIB_DIR)

uninstall_libs:
	$(hide)rm $(patsubst $(BUILD_LIB_DIR)%, $(INSTALL_LIB_DIR)%,$(BUILT_LIBS))

uninstall_bins:
	$(hide)rm $(patsubst $(BUILD_BIN_DIR)%, $(INSTALL_BIN_DIR)%,$(BUILT_BINS))
