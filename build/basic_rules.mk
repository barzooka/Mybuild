all: ${CONTENTS} 
	${hide}echo Build Finished!

clean:
	${hide}rm ${BUILD_OBJ_DIR} ${BUILD_BIN_DIR} ${BUILD_OUT_DIR} -rf

hello-build-system:
	${hide}echo =======================================================================
	${hide}echo My Build System version 1.0.0
	${hide}echo
	${hide}echo To start, add a build target name in CONTENTS variable in configure.mk.
	${hide}echo =======================================================================
