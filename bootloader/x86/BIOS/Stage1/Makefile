TOPDIR := ../../../..
include $(TOPDIR)/Makedefs


STAGE1_SRC = $(wildcard $(SRC_DIR)/*.S)
STAGE1_OBJ = $(STAGE1_SRC:$(SRC_DIR)/%.S=$(OBJ_DIR)/%.o)
STAGE1_BIN := $(BUILD_DIR)/Stage1.bin

TARGET := i386-elf
all: $(STAGE1_BIN)
	@

$(STAGE1_BIN): $(STAGE1_OBJ)
	@$(LD) $(LDFLAGS) -o $@ $^

clean:
	@$(RM) -r $(BUILD_DIR)
