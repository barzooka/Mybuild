$(eval $(call start-build-action, PREBUILT))

$(if $(filter install, $(LOCAL_PREBUILT_TYPE)), ,\
    $(if $(filter build, $(LOCAL_PREBUILT_TYPE)), , \
        $(error PREBUILT module must tell us when should we copy the prebuilt files. \
                Please set LOCAL_PREBUILT_TYPE to 'install' or 'build'. \
         ) \
    ) \
)

$(eval $(call prepare-args))

$(eval $(call build-prebuilt))
