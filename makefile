SRC_DIR = src
BUILD_DIR = build
OBJ_DIR=$(BUILD_DIR)/object

ASM = $(shell find $(SRC_DIR) -name "*.asm")
INC = $(shell find $(SRC_DIR) -name "*.inc")
OBJ = $(patsubst $(SRC_DIR)/%.asm, $(OBJ_DIR)/%.o, $(ASM))

TARGET = $(BUILD_DIR)/main

ALL = $(TARGET)

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.asm $(INC)
	@mkdir -p $(OBJ_DIR)
	nasm -f elf64 $< -o $@

$(TARGET) : $(OBJ)
	ld $^ -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)

print-%: ; @echo $* = $($*)

.PHONY: run clean