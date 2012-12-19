install_bins: $(INSTALL_BINS)
	$(hide)mkdir -p $(INSTALL_BIN_DIR)
	$(hide)cp $(INSTALL_BINS) $(INSTALL_BIN_DIR)

install_libs: $(INSTALL_LIBS)
	$(hide)mkdir -p $(INSTALL_LIB_DIR)
	$(hide)cp $(INSTALL_LIBS) $(INSTALL_LIB_DIR)

uninstall_libs:
	$(hide)rm $(patsubst $(BUILD_LIB_DIR)%, $(INSTALL_LIB_DIR)%,$(INSTALL_LIBS))

uninstall_bins:
	$(hide)rm $(patsubst $(BUILD_BIN_DIR)%, $(INSTALL_BIN_DIR)%,$(INSTALL_BINS))

ifeq ($(INSTALL_BINS),)
INSTALL_BINS_IF =
UNINSTALL_BINS_IF =
else
INSTALL_BINS_IF = install_bins
UNINSTALL_BINS_IF = uninstall_bins
endif

ifeq ($(INSTALL_LIBS),)
INSTALL_LIBS_IF =
UNINSTALL_LIBS_IF =
else
INSTALL_LIBS_IF = install_libs
UNINSTALL_LIBS_IF = uninstall_libs
endif

install: $(INSTALL_LIBS_IF) $(INSTALL_BINS_IF)

uninstall: $(UNINSTALL_LIBS_IF) $(UNINSTALL_BINS_IF)

