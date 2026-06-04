TARGET := Husky
BUILD := build
SOURCE := source

SOURCES := $(wildcard $(SOURCE)/*.c)

LIBS := -lctru -lm -lcitro3d

include $(DEVKITPRO)/3ds_rules
