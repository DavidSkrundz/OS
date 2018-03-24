TOPDIR := ..
include $(TOPDIR)/Makedefs


PREFIX := $(shell pwd)/compiler
PACKAGE_NAME := "OS"

GOALS :=
TARGET :=

BINUTILS_PATH = $(BUILD_DIR)/$(TARGET)-binutils
GCC_PATH = $(BUILD_DIR)/$(TARGET)-gcc
MINGW_HEADERS_PATH = $(BUILD_DIR)/$(TARGET)-headers
MINGW_CRT_PATH = $(BUILD_DIR)/$(TARGET)-crt
WINPTHREAD_PATH = $(BUILD_DIR)/$(TARGET)-winpthread

export PATH := $(PREFIX)/native/bin:$(PREFIX)/i386-elf/bin:$(PREFIX)/x86_64-elf/bin:$(PREFIX)/i686-w64-mingw32/bin:$(PREFIX)/x86_64-w64-mingw32/bin:$(PATH)


all:
	@git submodule init
	@git submodule update
	@$(MAKE) NATIVE_BINUTILS
	@$(MAKE) NATIVE_GCC
	@$(MAKE) CROSS_BINUTILS
	@$(MAKE) CROSS_GCC
	@$(MAKE) CROSS_MINGW


include Make.binutils
include Make.gcc
include Make.mingw


$(PREFIX):
	@mkdir -p $@


clean:
	@$(RM) -r $(BUILD_DIR)

.PHONY: clean-cross
clean-cross: clean
	@$(RM) -r compiler/i* compiler/x*

.PHONY: clean-toolchain
clean-toolchain: clean
	@$(RM) -r compiler/
