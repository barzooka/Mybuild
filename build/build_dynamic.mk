$(eval $(call start-build-action, SHARED))

$(eval $(call prepare-args))

LOCAL_CFLAGS += -fPIC

include $(BUILD_OBJECTS)

$(eval $(call build-dynamic))
