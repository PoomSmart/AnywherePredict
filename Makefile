DEBUG = 0
PACKAGE_VERSION = 1.1

ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest
	ARCHS = x86_64 i386
else
	TARGET = iphone:latest
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AnywherePredict
AnywherePredict_FILES = Tweak.xm
AnywherePredict_USE_SUBSTRATE = 1

include $(THEOS_MAKE_PATH)/tweak.mk

all::
ifeq ($(SIMULATOR),1)
	@rm -f /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(THEOS_OBJ_DIR)/*.dylib /opt/simject
	@cp -v $(PWD)/*.plist /opt/simject
endif
