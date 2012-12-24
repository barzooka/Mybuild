$(eval $(call start-build-action, JAVA-LIBRARY))

$(eval $(call prepare-args))

$(eval $(call build-java-jar, $(call java-lib-full-path, $(LOCAL_MODULE))))

