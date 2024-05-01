LOCAL_PATH := $(call my-dir)  

include $(CLEAR_VARS)  
  
LOCAL_MODULE := live555

SOURCE_LIST := $(wildcard $(LOCAL_PATH)/BasicUsageEnvironment/*.cpp)
SOURCE_LIST += $(wildcard $(LOCAL_PATH)/groupsock/*.cpp)
SOURCE_LIST += $(wildcard $(LOCAL_PATH)/groupsock/*.c)
SOURCE_LIST += $(wildcard $(LOCAL_PATH)/liveMedia/*.cpp)
SOURCE_LIST += $(wildcard $(LOCAL_PATH)/liveMedia/*.c)
SOURCE_LIST += $(wildcard $(LOCAL_PATH)/UsageEnvironment/*.cpp)
SOURCE_LIST += $(wildcard $(LOCAL_PATH)/android-ifaddrs/*.c)

LOCAL_SRC_FILES := $(SOURCE_LIST)

# ABI folder sorting for OpenSSL
ABI_FOLDER := NA
ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
	ABI_FOLDER := arm
else ifeq ($(TARGET_ARCH_ABI), arm64-v8a)
	ABI_FOLDER := arm64
else ifeq ($(TARGET_ARCH_ABI), x86)
	ABI_FOLDER := x86
else ifeq ($(TARGET_ARCH_ABI), x86_64)
	ABI_FOLDER := x86_64
endif

# Linker to local OpenSSL libs
LOCAL_LDLIBS += $(LOCAL_PATH)/openssl/$(ABI_FOLDER)/libcrypto_1_1.so 
LOCAL_LDLIBS += $(LOCAL_PATH)/openssl/$(ABI_FOLDER)/libssl_1_1.so


LOCAL_C_INCLUDES += $(LOCAL_PATH)/BasicUsageEnvironment/include \
					$(LOCAL_PATH)/liveMedia/include \
					$(LOCAL_PATH)/groupsock/include \
					$(LOCAL_PATH)/UsageEnvironment/include \
					$(LOCAL_PATH)/android-ifaddrs/include \
					$(LOCAL_PATH)/openssl/include 


LOCAL_CPPFLAGS += -fexceptions -DXLOCALE_NOT_USED=1 -DNULL=0 -DNO_SSTREAM=1 -UIP_ADD_SOURCE_MEMBERSHIP -DSOCKLEN_T=socklen_t
LOCAL_CPPFLAGS += -DNO_STD_LIB

include $(BUILD_SHARED_LIBRARY) 
