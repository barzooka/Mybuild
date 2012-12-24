$(eval $(call start-build-action, JAVA-EXECUTABLE))

$(eval $(call prepare-args))
LOCAL_JAR_OPERATION := cef
$(eval $(call build-java-jar))
