# =========================
# HUSKY! 3DS PLATFORMER
# =========================

TARGET  := Husky
BUILD   := build
SOURCE  := source
ASSETS  := assets

ELF     := $(BUILD)/$(TARGET).elf
3DSX    := $(BUILD)/$(TARGET).3dsx

SOURCES := $(wildcard $(SOURCE)/*.c)

# devkitPro tools
CC      := arm-none-eabi-gcc
OBJCOPY := arm-none-eabi-objcopy

# 3DS tools
SMDH    := $(DEVKITPRO)/tools/bin/smdhtool

LIBS := -lcitro3d -lctru -lm

CFLAGS := -Wall -O2 -mfloat-abi=hard -mtp=soft -D__3DS__

# =========================
# DEFAULT TARGET
# =========================
all: $(3DSX)

# =========================
# BUILD ELF
# =========================
$(ELF): $(SOURCES)
	mkdir -p $(BUILD)
	$(CC) $(CFLAGS) $^ $(LIBS) -o $@

# =========================
# BUILD 3DSX
# =========================
$(3DSX): $(ELF) assets/icon.png
	$(SMDH) assets/icon.png -s "Husky!" -l "Husky 3DS Game" -p "Indie Dev" -o $(BUILD)/icon.smdh
	3dsxtool $(ELF) $(3DSX) --smdh=$(BUILD)/icon.smdh

# =========================
# CLEAN
# =========================
clean:
	rm -rf $(BUILD)

# =========================
# RUN (CITRA opcional)
# =========================
run: all
	citra $(3DSX)
