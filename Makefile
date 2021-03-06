#	author: Nicholas Buckeridge
#	email: bucknich@gmail.com
#	date: 30 December 2013 7:53AM
#	description:	This is yet another makefile for the stm32f4. It was built for
#			beginners like myself and the advanced user that wants to get 
#			the job done quikly and simply. I have added support for  the
#			stm32f4 peripherals library and the newlib stubs for OS level
#			functionality. Newlib stubs can be found in
#			(project root)/library/default/src/syscall.cpp. This project is
#			a C++ compiler project, if changes are necessary you can change
#			the makefile variables to suite your needs. This is a simple
#			project. Any code you have written (*.cpp/*.c) can be placed in
#			the (project root)/code/src/ and headers go in
#			(project root)/code/inc folder. The makefile is designed to
#			automaticly detect any source files within the src directory and
#			compile them into the project.


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
PERIPHERAL_DIR = $(LIBRARY_DIR)peripherals/
DEFAULT_DIR = $(LIBRARY_DIR)default/
OUTPUT_DIR = $(BUILD_DIR)output/
OBJECT_DIR = $(BUILD_DIR)objects/
#SOURCE_MAIN_DIR = $(CODE_DIR)src/
SOURCE_LIBRARY_DIR = $(PERIPHERAL_DIR)src/
SOURCE_PERIPHERAL_DIR = $(DEFAULT_DIR)src/

# files with paths attached
_C_FILES = $(wildcard $(SOURCE_DIR)*.c)
_C_DEFAULT_FILES = $(wildcard $(DEFAULT_DIR)src/*.c)
_C_PERIPHERAL_FILES = $(wildcard $(PERIPHERAL_DIR)src/*.c)
_CPP_FILES = $(wildcard $(SOURCE_DIR)*.cpp)
_CPP_DEFAULT_FILES = $(wildcard $(DEFAULT_DIR)src/*.cpp)
_CPP_PERIPHERAL_FILES = $(wildcard $(PERIPHERAL_DIR)src/*.cpp)
_STA_FILES = $(wildcard $(STARTUP_DIR)*.s)
_SRC_FILES = $(_CPP_FILES) $(_C_FILES) $(_C_DEFAULT_FILES) $(_C_PERIPHERAL_FILES) $(_CPP_DEFAULT_FILES) $(_CPP_PERIPHERAL_FILES) $(_STA_FILES)
_OBJ_FILES = $(addprefix $(OBJECT_DIR),$(notdir $(_CPP_FILES:.cpp=.o)))
_OBJ_FILES += $(addprefix $(OBJECT_DIR),$(notdir $(_C_FILES:.c=.o)))
_OBJ_FILES += $(addprefix $(OBJECT_DIR),$(notdir $(_CPP_DEFAULT_FILES:.cpp=.o)))
_OBJ_FILES += $(addprefix $(OBJECT_DIR),$(notdir $(_C_DEFAULT_FILES:.c=.o)))
_OBJ_FILES += $(addprefix $(OBJECT_DIR),$(notdir $(_CPP_PERIPHERAL_FILES:.cpp=.o)))
_OBJ_FILES += $(addprefix $(OBJECT_DIR),$(notdir $(_C_PERIPHERAL_FILES:.c=.o)))
_OBJ_FILES += $(addprefix $(OBJECT_DIR),$(notdir $(_STA_FILES:.s=.o)))
_LNK_FILES = $(wildcard $(LINKER_DIR)*.ld)

#file names without paths
C_FILES = $(_C_FILES:$(SOURCE_DIR)%=%)
C_DEFAULT_FILES = $(_C_DEFAULT_FILES:$(DEFAULT_DIR)src/%=%)
C_PERIPHERAL_FILES = $(_C_PERIPHERAL_FILES:$(PERIPHERAL_DIR)src/%=%)
CPP_FILES = $(_CPP_FILES:$(SOURCE_DIR)%=%)
CPP_DEFAULT_FILES = $(_CPP_DEFAULT_FILES:$(DEFAULT_DIR)src/%=%)
CPP_PERIPHERAL_FILES = $(_CPP_PERIPHERAL_FILES:$(PERIPHERAL_DIR)src/%=%)
STA_FILES = $(_STA_FILES:$(STARTUP_DIR)%=%)
SRC_FILES = $(CPP_FILES) $(C_FILES) $(STA_FILES) $(C_DEFAULT_FILES) $(C_PERIPHERAL_FILES)
SRC_FILES += $(CPP_DEFAULT_FILES) $(CPP_PERIPHERAL_FILES)
OBJ_FILES = $(_OBJ_FILES:$(OBJECT_DIR)%=%)

#include directories
HEADERS = $(CODE_DIR)inc/
HEADERS += $(LIBRARY_DIR)default/inc/
HEADERS += $(LIBRARY_DIR)peripherals/inc/

# Tool configuration
TOOLCHAIN_PATH = #leave empty if your toolchain has been added to the $PATH shell variable
TOOLCHAIN = $(TOOLCHAIN_PATH)arm-none-eabi-
CC = $(TOOLCHAIN)g++
CXX = $(TOOLCHAIN)g++
AS = $(TOOLCHAIN)gcc
LD = $(TOOLCHAIN)g++
OBJCOPY = $(TOOLCHAIN)objcopy
ST_FLASH_PATH = #leave empty if your toolchain has been added to the $PATH shell variable


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
LDFLAGS+=-T $(LINKER_DIR)stm32_flash.ld





#vpath %.c SOURCE_DIR SOURCE_LIBRARY_DIR SOURCE_PERIPHERAL_DIR
#vpath %.cpp SOURCE_DIR SOURCE_LIBRARY_DIR SOURCE_PERIPHERAL_DIR


all: $(OUTPUT_DIR)$(TARGET_ELF)
	$(OBJCOPY) -O ihex $(OUTPUT_DIR)$(TARGET_ELF) $(OUTPUT_DIR)$(TARGET_HEX)
	$(OBJCOPY) -O binary $(OUTPUT_DIR)$(TARGET_ELF) $(OUTPUT_DIR)$(TARGET_BIN)

#compile all objects into single executable
$(OUTPUT_DIR)$(TARGET_ELF):$(_OBJ_FILES)
	$(LD) $(LDFLAGS) $(_OBJ_FILES) -o $(OUTPUT_DIR)$(TARGET_ELF)

#generate objects
$(OBJECT_DIR)%.o: $(SOURCE_DIR)%.c
	$(CC) $(CXXFLAGS) $^ -c -o $@
$(OBJECT_DIR)%.o: $(SOURCE_DIR)%.cpp
	$(CXX) $(CXXFLAGS) $^ -c -o $@
$(OBJECT_DIR)%.o: $(SOURCE_LIBRARY_DIR)%.c
	$(CC) $(CXXFLAGS) $^ -c -o $@
$(OBJECT_DIR)%.o: $(SOURCE_LIBRARY_DIR)%.cpp
	$(CXX) $(CXXFLAGS) $^ -c -o $@
$(OBJECT_DIR)%.o: $(SOURCE_PERIPHERAL_DIR)%.c
	$(CC) $(CXXFLAGS) $^ -c -o $@
$(OBJECT_DIR)%.o: $(SOURCE_PERIPHERAL_DIR)%.cpp
	$(CXX) $(CXXFLAGS) $^ -c -o $@
$(OBJECT_DIR)%.o: $(STARTUP_DIR)%.s
	$(CXX) $(CXXFLAGS) $^ -c -o $@

clean:
	rm -f $(_OBJ_FILES)
	rm -f $(OUTPUT_DIR)$(TARGET_ELF)
	rm -f $(OUTPUT_DIR)$(TARGET_HEX)
	rm -f $(OUTPUT_DIR)$(TARGET_BIN)
flash:
	st-flash write $(OUTPUT_DIR)$(TARGET_BIN) 0x8000000
flash_erase:
	st-flash erase

#debug variables
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
	@echo _C_DEFAULT_FILES = $(_C_DEFAULT_FILES)
	@echo _C_PERIPHERAL_FILES = $(_C_PERIPHERAL_FILES)
	@echo _CPP_FILES = $(_CPP_FILES)
	@echo _CPP_DEFAULT_FILES = $(_CPP_DEFAULT_FILES)
	@echo _CPP_PERIPHERAL_FILES = $(_CPP_PERIPHERAL_FILES)
	@echo _STA_FILES = $(_STA_FILES)
	@echo _SRC_FILES = $(_SRC_FILES)
	@echo _OBJ_FILES = $(_OBJ_FILES)
	@echo _LNK_FILES = $(_LNK_FILES)
	@echo
	@echo C_FILES = $(C_FILES)
	@echo C_DEFAULT_FILES = $(C_DEFAULT_FILES)
	@echo C_PERIPHERAL_FILES = $(C_PERIPHERAL_FILES)
	@echo CPP_FILES = $(CPP_FILES)
	@echo CPP_DEFAULT_FILES = $(CPP_DEFAULT_FILES)
	@echo CPP_PERIPHERAL_FILES = $(CPP_PERIPHERAL_FILES)
	@echo STA_FILES = $(STA_FILES)
	@echo SRC_FILES = $(SRC_FILES)
	@echo OBJ_FILES = $(OBJ_FILES)

help:
	@echo this is to do still. will print out how to use this make file.
