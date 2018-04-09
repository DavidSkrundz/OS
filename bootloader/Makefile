TOPDIR := ..
include $(TOPDIR)/Makedefs

FOLDERS = $(shell ls -1 -F | grep / | sed 's/\(.*\)\//\1/')

all clean:
	@

define RECURSE_TEMPLATE =
  .PHONY: $(1)-all
  $(1)-all:
	@$$(MAKE) -C $(1) all
  .PHONY: $(1)-clean
  $(1)-clean:
	@$$(MAKE) -C $(1) clean

  all: $(1)-all
  clean: $(1)-clean
endef

$(foreach folder,$(FOLDERS),$(eval $(call RECURSE_TEMPLATE,$(folder))))
