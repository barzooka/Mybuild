$(eval $(call start-build-action, JAVA-LIBRARY))

$(if $(LOCAL_JAVA_MAIN_ENTRY), $(error $(LOCAL_MODULE): LOCAL_JAVA_MAIN_ENTRY should not specified in JAVA_LIBRARY module.))

$(eval $(call prepare-args))

LOCAL_JAR_OPERATION := cf
$(eval $(call build-java-jar))

