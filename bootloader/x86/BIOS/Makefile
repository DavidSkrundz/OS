TOPDIR := ../../..
include $(TOPDIR)/Makedefs

FOLDERS = $(shell ls -1 -F | grep / | sed 's/\(.*\)\//\1/')

STAGE2_BIN := Stage2/$(BUILD_DIR)/Stage2.bin

all:
	@$(MAKE) -C Stage1 $@

clean:
	@

define RECURSE_TEMPLATE =
  .PHONY: $(1)-clean
  $(1)-clean:
	@$$(MAKE) -C $(1) clean

  clean: $(1)-clean
endef

$(foreach folder,$(FOLDERS),$(eval $(call RECURSE_TEMPLATE,$(folder))))
