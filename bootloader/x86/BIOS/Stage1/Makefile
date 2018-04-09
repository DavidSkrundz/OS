TOPDIR := ../../../..
include $(TOPDIR)/Makedefs


STAGE1_SRC = $(wildcard $(SRC_DIR)/*.S)
STAGE1_ASM = $(STAGE1_SRC:$(SRC_DIR)/%.S=$(INTERMEDIATE_DIR)/%.asm)
STAGE1_OBJ = $(STAGE1_SRC:$(SRC_DIR)/%.S=$(OBJ_DIR)/%.o)
STAGE1_BIN := $(BUILD_DIR)/Stage1.bin

GCCFLAGS += -DBLOCK_SIZE=$(BLOCK_SIZE)


$(call declare_variable, BLOCK_SIZE)


TARGET := i386-elf
all: $(STAGE1_BIN)
	@

$(STAGE1_BIN): $(STAGE1_OBJ)
	@$(LD) $(LDFLAGS) -o $@ $^

$(STAGE1_ASM): $(INTERMEDIATE_DIR)/%.asm: $(SRC_DIR)/%.S \
                                          BLOCK_SIZE \
                                        | $(INTERMEDIATE_DIR)
	@:$(call assert_defined, BLOCK_SIZE, Bytes per sector)
	@$(NATIVE_GCC) -E $(GCCFLAGS) -o $@ $<

clean:
	@$(RM) -r $(BUILD_DIR)
