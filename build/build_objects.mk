$(foreach src, $(LOCAL_SRC_FILES), \
	$(eval $(call prepare-translate-c-o, $(src))) \
	$(eval $(call translate-c-o, $(src))))

