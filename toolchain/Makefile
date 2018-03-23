TOPDIR := ..
include $(TOPDIR)/Makedefs


PREFIX := $(shell pwd)/compiler
PACKAGE_NAME := "OS"

GOALS :=
TARGET :=
BINUTILS_TARGET_FLAGS :=
GCC_PLATFORM_FLAGS :=
GCC_TARGET_FLAGS :=

BINUTILS_PATH = $(BUILD_DIR)/$(TARGET)-binutils
GCC_PATH = $(BUILD_DIR)/$(TARGET)-gcc

export PATH := $(PREFIX)/native/bin:$(PATH)


all:
	@git submodule init
	@git submodule update
	@$(MAKE) NATIVE_BINUTILS
	@$(MAKE) NATIVE_GCC


ifeq ($(UNAME), Linux)
  NATIVE_BINUTILS: BINUTILS_TARGET_FLAGS=--enable-64-bit-bfd
  NATIVE_BINUTILS: .BINUTILS
endif
.PHONY: NATIVE_BINUTILS
NATIVE_BINUTILS: TARGET=native
NATIVE_BINUTILS: GOALS=all install
NATIVE_BINUTILS:
ifeq ($(UNAME), Darwin)
	@echo Binutils does not compile for macOS
endif
	@

ifeq ($(UNAME), Linux)
  NATIVE_GCC: GCC_TARGET_FLAGS=--disable-multilib
endif
.PHONY: NATIVE_GCC
NATIVE_GCC: TARGET=native
NATIVE_GCC: GOALS=all install-strip
NATIVE_GCC: .GCC
	@


.PHONY: .BINUTILS
.BINUTILS: | $(BUILD_DIR) $(PREFIX)
	@:$(call assert_defined, GOALS, Missing GOALS)
	@:$(call assert_defined, TARGET, Missing TARGET)
	@cd sources/binutils/ && git reset --hard && git clean -fd
	@mkdir -p $(BINUTILS_PATH)
	@echo Configuring $(TARGET)-binutils
	@cd $(BINUTILS_PATH) && ../../sources/binutils/configure \
		--prefix=$(PREFIX)/$(TARGET) \
		--disable-nls \
		--enable-interwork \
		--disable-werror \
		--disable-multilib \
		$(BINUTILS_TARGET_FLAGS) \
			1> ../$(TARGET)-binutils-config.out.txt \
			2> ../$(TARGET)-binutils-config.err.txt
	@$(foreach goal,$(GOALS), echo Building $(TARGET)-binutils $(goal) && \
		time $(MAKE) -C $(BINUTILS_PATH) $(goal) \
			1> $(BUILD_DIR)/$(TARGET)-binutils-$(goal).out.txt \
			2> $(BUILD_DIR)/$(TARGET)-binutils-$(goal).err.txt \
		&&) true

ifeq ($(UNAME), Darwin)
  .GCC: GCC_PLATFORM_FLAGS=\
	--with-gmp=$(call brew_path, gmp) \
	--with-mpfr=$(call brew_path, mpfr) \
	--with-mpc=$(call brew_path, libmpc) \
	--with-isl=$(call brew_path, isl)
endif
.PHONY: .GCC
.GCC: | $(BUILD_DIR) $(PREFIX)
	@:$(call assert_defined, GOALS, Missing GOALS)
	@:$(call assert_defined, TARGET, Missing TARGET)
	@cd sources/gcc/ && git reset --hard && git clean -fd
	@-cd sources/gcc/ && git apply $(PREFIX)/../patches/gcc/all-*.patch
	@mkdir -p $(GCC_PATH)
	@echo Configuring $(TARGET)-gcc
	@cd $(GCC_PATH) && ../../sources/gcc/configure \
		--prefix=$(PREFIX)/$(TARGET) \
		--with-pkgversion="$(PACKAGE_NAME) $(TARGET) GCC" \
		--enable-languages=c,c++ \
		--disable-nls \
		--with-system-zlib \
		--enable-checking=release \
		$(GCC_PLATFORM_FLAGS) \
		$(GCC_TARGET_FLAGS) \
			1> ../$(TARGET)-gcc-config.out.txt \
			2> ../$(TARGET)-gcc-config.err.txt
	@if [[ "$(TARGET)" == "native" ]]; then \
		echo Building $(TARGET)-gcc all \(initial\); \
	fi
	@-if [[ "$(TARGET)" == "native" ]]; then \
		time $(MAKE) -C $(GCC_PATH) all \
			1> $(BUILD_DIR)/$(TARGET)-gcc-all_1.out.txt \
			2> $(BUILD_DIR)/$(TARGET)-gcc-all_1.err.txt; \
	fi
	@$(foreach goal,$(GOALS), echo Building $(TARGET)-gcc $(goal) && \
		time $(MAKE) -C $(GCC_PATH) $(goal) \
			1> $(BUILD_DIR)/$(TARGET)-gcc-$(goal).out.txt \
			2> $(BUILD_DIR)/$(TARGET)-gcc-$(goal).err.txt \
		&&) true


$(PREFIX):
	@mkdir -p $@


clean:
	@$(RM) -r $(BUILD_DIR)

.PHONY: clean-toolchain
clean-toolchain: clean
	@$(RM) -r compiler/
