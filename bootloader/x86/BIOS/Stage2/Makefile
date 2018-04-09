TOPDIR := ../../../..
include $(TOPDIR)/Makedefs


STAGE2_SRC = $(wildcard $(SRC_DIR)/*.S)
STAGE2_OBJ = $(STAGE2_SRC:$(SRC_DIR)/%.S=$(OBJ_DIR)/%.o)
STAGE2_BIN := $(BUILD_DIR)/Stage2.bin

TARGET := i386-elf
all: $(STAGE2_BIN)
	@

$(STAGE2_BIN): $(STAGE2_OBJ)
	@$(LD) $(LDFLAGS) -o $@ $^

clean:
	@$(RM) -r $(BUILD_DIR)
