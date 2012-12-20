$(eval $(call start-build-action, STATIC))

$(eval $(call prepare-args))

include $(BUILD_OBJECTS)

$(eval $(call build-static))
