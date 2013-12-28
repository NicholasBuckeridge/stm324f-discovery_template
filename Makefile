#name of application
TARGET = main
#name of target outputs
TARGET_ELF = $(TARGET).elf
TARGET_BIN = $(TARGET).bin
TARGET_HEX = $(TARGET).hex


# directories
CODE_DIR = code/
LIBRARY_DIR = library/
BUILD_DIR = build/
SOURCE_DIR = $(CODE_DIR)src/
STARTUP_DIR = $(LIBRARY_DIR)startup/
LINKER_DIR = $(LIBRARY_DIR)linker/
OUTPUT_DIR = $(BUILD_DIR)output/
OBJECT_DIR = $(BUILD_DIR)objects/

# files with paths attached
_C_FILES = $(wildcard $(SOURCE_DIR)*.c)
_CPP_FILES = $(wildcard $(SOURCE_DIR)*.cpp)
_STA_FILES = $(wildcard $(STARTUP_DIR)*.s)
_SRC_FILES = $(_CPP_FILES) $(_C_FILES) # $(_STA_FILES)
_OBJ_FILES = $(addprefix $(OBJECT_DIR),$(notdir $(_CPP_FILES:.cpp=.o)))
#_OBJ_FILES = $(patsubst $(SOURCE_DIR)%.cpp,$(OBJECT_DIR)%.o,$(_CPP_FILES:$(SOURCE_DIR)%=%))
#_OBJ_FILES += $(patsubst $(SOURCE_DIR)%.c,$(OBJECT_DIR)%.o,$(_C_FILES:$(SOURCE_DIR)%=%))
#_OBJ_FILES += $(patsubst $(SOURCE_DIR)%.s,$(OBJECT_DIR)%.o,$(_STA_FILES:$(STARTUP_DIR)%=%))
_LNK_FILES = $(wildcard $(LINKER_DIR)*.ld)

#file names without paths
C_FILES = $(_C_FILES:$(SOURCE_DIR)%=%)
CPP_FILES = $(_CPP_FILES:$(SOURCE_DIR)%=%)
STA_FILES = $(_STA_FILES:$(STARTUP_DIR)%=%)
SRC_FILES = $(CPP_FILES) $(C_FILES) $(STA_FILES)
OBJ_FILES = $(_OBJ_FILES:$(OBJECT_DIR)%=%)

#include directories
HEADERS = 
HEADERS += 
HEADERS += 
HEADERS += 
HEADERS += 
HEADERS += 
HEADERS += 
HEADERS += 
HEADERS += 
HEADERS += 


LIB_PATH =





#libraries to link



# Tool configuration
TOOLCHAIN = arm-none-eabi-
CC = $(TOOLCHAIN)gcc
CXX = $(TOOLCHAIN)g++
AS = $(TOOLCHAIN)gcc
LD = $(TOOLCHAIN)gcc
OBJCOPY = $(TOOLCHAIN)objcopy

# Architecture configuration
ARCH_FLAGS=-mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 

# gcc compiler flags
CFLAGS += -O0 -ggdb3
CFLAGS += $(ARCH_FLAGS)
CFLAGS += -flto
CFLAGS += -ffunction-sections
CFLAGS +=  -fdata-sections
CFLAGS += $(foreach i, $(HEADERS), -I$(i))

# g++ compiler flags
CXXFLAGS = $(CFLAGS)
CXXFLAGS += -fno-rtti -fno-exceptions
CXXFLAGS += -std=c++11

# Flags for gcc as linker
LDFLAGS=$(ARCH_FLAGS)
LDFLAGS+=-Wl,--gc-sections
LDFLAGS+=$(foreach i, $(HEADERS), -L$(i))
LDFLAGS+=-T $(LDSCRIPT)


print:
	@echo name of application:
	@echo TARGET = $(TARGET)
	@echo name of target outputs
	@echo TARGET_ELF = $(TARGET_ELF)
	@echo TARGET_BIN = $(TARGET_BIN)
	@echo TARGET_HEX = $(TARGET_HEX)
	@echo
	@echo directories
	@echo CODE_DIR = $(CODE_DIR)
	@echo LIBRARY_DIR = $(LIBRARY_DIR)
	@echo BUILD_DIR = $(BUILD_DIR)
	@echo SOURCE_DIR = $(SOURCE_DIR)
	@echo STARTUP_DIR = $(STARTUP_DIR)
	@echo LINKER_DIR = $(LINKER_DIR)
	@echo OUTPUT_DIR = $(OUTPUT_DIR)
	@echo OBJECT_DIR = $(OBJECT_DIR)
	@echo
	@echo files with paths attached:
	@echo _C_FILES = $(_C_FILES)
	@echo _CPP_FILES = $(_CPP_FILES)
	@echo _STA_FILES = $(_STA_FILES)
	@echo _SRC_FILES = $(_SRC_FILES)
	@echo _OBJ_FILES = $(_OBJ_FILES)
	@echo _LNK_FILES = $(_LNK_FILES)
	@echo
	@echo C_FILES = $(C_FILES)
	@echo CPP_FILES = $(CPP_FILES)
	@echo STA_FILES = $(STA_FILES)
	@echo SRC_FILES = $(SRC_FILES)
	@echo OBJ_FILES = $(OBJ_FILES)

