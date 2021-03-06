TOPDIR := ../../../..
include $(TOPDIR)/Makedefs


STAGE1_SRC = $(wildcard $(SRC_DIR)/*.S)
STAGE1_ASM = $(STAGE1_SRC:$(SRC_DIR)/%.S=$(INTERMEDIATE_DIR)/%.asm)
STAGE1_OBJ = $(STAGE1_SRC:$(SRC_DIR)/%.S=$(OBJ_DIR)/%.o)
STAGE1_BIN := $(BUILD_DIR)/Stage1.bin

GCCFLAGS += -DBLOCK_SIZE=$(BLOCK_SIZE)
GCCFLAGS += -DSTAGE2_LBA=$(STAGE2_LBA)
GCCFLAGS += -DSTAGE2_SIZE=$(STAGE2_SIZE)


$(call declare_variable, BLOCK_SIZE)
$(call declare_variable, STAGE2_LBA)
$(call declare_variable, STAGE2_SIZE)


TARGET := i386-elf
all: $(STAGE1_BIN)
	@

$(STAGE1_BIN): $(STAGE1_OBJ)
	@$(LD) $(LDFLAGS) -o $@ $^
	@if [[ `$(FILE_SIZE_BYTES) $@` -gt 446 ]]; then \
		echo "BIOS stage1 bootloader too large:"`$(FILE_SIZE_BYTES) $@`"/446 bytes"; \
		rm -f $@; \
		exit 1; \
	fi

$(STAGE1_ASM): $(INTERMEDIATE_DIR)/%.asm: $(SRC_DIR)/%.S \
                                          BLOCK_SIZE STAGE2_LBA STAGE2_SIZE \
                                        | $(INTERMEDIATE_DIR)
	@:$(call assert_defined, BLOCK_SIZE, Bytes per sector)
	@:$(call assert_defined, STAGE2_LBA, Starting LBA of Stage2)
	@:$(call assert_defined, STAGE2_SIZE, Size of Stage2 in sectors)
	@$(NATIVE_GCC) -E $(GCCFLAGS) -o $@ $<

clean:
	@$(RM) -r $(BUILD_DIR)
