SRC_DIR = src
BUILD_DIR = build

ENTRY = $(SRC_DIR)/main.asm
ASM = $(shell find $(SRC_DIR) -name "*.asm") $(shell find $(SRC_DIR) -name "*.inc")
OBJ = $(BUILD_DIR)/main.o
TARGET = $(BUILD_DIR)/main

ALL = $(TARGET)

$(OBJ) : $(ASM)
	@mkdir -p $(BUILD_DIR)
	nasm -f elf64 $(ENTRY) -o $@

$(TARGET) : $(OBJ)
	ld $^ -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: run clean