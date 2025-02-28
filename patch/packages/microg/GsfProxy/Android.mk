# Copyright (c) 2015 μg Project Team
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := GsfProxy
LOCAL_MODULE_TAGS := optional
LOCAL_PACKAGE_NAME := GsfProxy

gsfproxy_root  := $(LOCAL_PATH)
gsfproxy_dir   := services-framework-proxy
gsfproxy_out   := $(ANDROID_BUILD_TOP)/$(TARGET_COMMON_OUT_ROOT)/obj/APPS/GsfProxy_intermediates
gsfproxy_build := $(gsfproxy_root)/$(gsfproxy_dir)/build
gsfproxy_apk   := build/outputs/apk/services-framework-proxy-release-unsigned.apk

$(gsfproxy_out):
	mkdir -p $(gsfproxy_out)

$(gsfproxy_root)/$(gsfproxy_dir)/$(gsfproxy_apk): $(gsfproxy_out)
	rm -rf $(gsfproxy_build)
	ln -sf $(gsfproxy_out) $(ANDROID_BUILD_TOP)/$(gsfproxy_build)
	echo "sdk.dir=$(ANDROID_HOME)" > $(gsfproxy_root)/local.properties
	cd $(gsfproxy_root) && git submodule update --recursive --init
	cd $(gsfproxy_root)/$(gsfproxy_dir) && JAVA_TOOL_OPTIONS="$(JAVA_TOOL_OPTIONS) -Dfile.encoding=UTF8" ../gradlew assembleRelease

LOCAL_CERTIFICATE := platform
LOCAL_SRC_FILES := $(gsfproxy_dir)/$(gsfproxy_apk)
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)

include $(BUILD_PREBUILT)
