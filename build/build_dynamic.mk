ifneq ($(BUILD_ACTION_INCLUDED),)
$(error For MODULE $(LOCAL_MODULE), ONLY ONE BUILD ACTION ALLOWD after CLEAR_VARS)
endif

BUILD_ACTION_INCLUDED := included

LOCAL_TARGET_TYPE := SHARED

$(eval $(call prepare-args))

LOCAL_CFLAGS += -fPIC

include $(BUILD_OBJECTS)

$(eval $(call build-dynamic))
