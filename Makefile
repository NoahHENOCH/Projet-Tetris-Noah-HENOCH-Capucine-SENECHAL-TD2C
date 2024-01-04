CC := gcc
SRC_DIR ?= src
OBJ_DIR ?= obj
CFLAGS ?= -Wall -MMD -g
LDFLAGS := -lSDL2


OBJS := $(shell find $(SRC_DIR) -name "*.c" | sed 's/.c$$/.o/g' | sed 's/$(SRC_DIR)/$(OBJ_DIR)/g')
DIRSOBJ := $(shell find $(SRC_DIR) -type d |sed 's/$(SRC_DIR)/$(OBJ_DIR)/g')
DEPS := $(OBJS : .o = .d)
TARGET ?= tetris

all : $(TARGET)

objdirs : 
	$(shell for dir in $(DIRSOBJ); do mkdir -p "$$dir"; done)


$(TARGET) : objdirs $(OBJS)
	$(CC) -o $(TARGET) $(OBJS) $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@


try: $(TARGET)
	./$(TARGET)

clean :
	rm -rf $(OBJ_DIR)

mrproper : clean
	rm $(TARGET)

-include $(DEPS)