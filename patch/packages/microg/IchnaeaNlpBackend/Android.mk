LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := IchnaeaNlpBackend
LOCAL_MODULE_TAGS := optional
LOCAL_PACKAGE_NAME := IchnaeaNlpBackend

ichnaea_root  := $(LOCAL_PATH)
ichnaea_out   := $(OUT_DIR)/target/common/obj/APPS/$(LOCAL_MODULE)_intermediates
ichnaea_build := $(ichnaea_root)/build
ichnaea_apk   := build/outputs/apk/IchnaeaNlpBackend-release-unsigned.apk

$(ichnaea_out):
	mkdir -p $(ichnaea_out)

$(ichnaea_root)/$(ichnaea_apk): $(ichnaea_out)
	rm -Rf $(ichnaea_build)
	ln -sf $(ANDROID_BUILD_TOP)/$(ichnaea_out) $(ichnaea_build)
	cd $(ichnaea_root) && JAVA_TOOL_OPTIONS="$(JAVA_TOOL_OPTIONS) -Dfile.encoding=UTF8" ./gradlew assembleRelease

LOCAL_CERTIFICATE := platform
LOCAL_SRC_FILES := $(ichnaea_apk)
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)

include $(BUILD_PREBUILT)
