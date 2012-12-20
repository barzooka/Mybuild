$(eval $(call start-build-action, EXECUTABLE))

$(eval $(call prepare-args))

include $(BUILD_OBJECTS)

$(eval $(call build-executable))
