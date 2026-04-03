SRC_DIR = src
BUILD_DIR = build
OBJ_DIR=$(BUILD_DIR)/object
DEBUG_DIR=$(BUILD_DIR)/debug

ASM = $(shell find $(SRC_DIR) -name "*.asm")
INC = $(shell find $(SRC_DIR) -name "*.inc")
OBJ = $(patsubst $(SRC_DIR)/%.asm, $(OBJ_DIR)/%.o, $(ASM))
DEBUG_OBJ = $(patsubst $(SRC_DIR)/%.asm, $(DEBUG_DIR)/%.o, $(ASM))

TARGET = $(BUILD_DIR)/main

DEBUG_TARGET = $(BUILD_DIR)/debug_main

ALL = $(TARGET)

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.asm $(INC)
	@mkdir -p $(@D)
	nasm -f elf64 $< -o $@

$(TARGET) : $(OBJ)
	ld $^ -o $@


$(DEBUG_DIR)/%.o : $(SRC_DIR)/%.asm $(INC)
	@mkdir -p $(@D)
	nasm -f elf64 -g -F dwarf $< -o $@

$(DEBUG_TARGET) : $(DEBUG_OBJ)
	ld $^ -o $@

run: $(TARGET)
	./$(TARGET)

debug: $(DEBUG_TARGET)
	gdb $(DEBUG_TARGET)

clean:
	rm -rf $(BUILD_DIR)

print-%: ; @echo $* = $($*)

.PHONY: run clean