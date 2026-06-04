TARGET := Husky
BUILD := build
SOURCES := source/main.c

ELF := $(BUILD)/$(TARGET).elf
3DSX := $(BUILD)/$(TARGET).3dsx

LIBS := -lctru -lm

include $(DEVKITPRO)/3ds_rules
