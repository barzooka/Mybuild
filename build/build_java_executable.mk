$(eval $(call start-build-action, JAVA-EXECUTABLE))

$(eval $(call prepare-args))

$(eval $(call build-java-jar, $(call java-bin-full-path, $(LOCAL_MODULE))))
