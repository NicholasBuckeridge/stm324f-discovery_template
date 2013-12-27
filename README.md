stm324f-discovery_template
==========================

A stm43f4 discovery makefile template project that supports C++

I am still debating on a directory structure but I am thinking of something along this:

stm32f4-discovery_template/				# The root directory for the project
|------	code/						# This directory will contain all code typed by the user
|	|------	inc/					# Header files for the user created code
|	|	|------	header.h			# This just represents any header files the user creates
|	|------	src/					# Source files made by user
|		|------	main.cpp			# Main file
|		|------	source.cpp			# This just represents any source files the user creates
|------	library/					# This folder holds everything stm32f4 related
|	|------	linker/					# linker dir
|	|	|------	stm32f4_flash.ld		# linker script for the linker
|	|------	peripherals/...				# this folder will have the peripherals library in it
|	|------	startup/				# startup folder
|	|	|------	startup_stm32f4.s/c		# contains startup code in either assembly or c/cpp form
|	|------	default/				# This directory holds any of the default files that stm32f4 need to operate
|		|------	inc/				# 
|			|------	stm32f4xx_conf.h	# 
|			|------	stm32f4xx_it.h		# 
|			|------	stm32f4xx.h		# 
|			|------	stm32f4_discovery.h	# 
|		|------	src/				# 
|			|------	stm32f4xx_it.cpp	# 
|			|------	system_stm32f4xx.cpp	# 
|			|------	stm32f4_discovery.c	# 
|			|------	newlib_stubs.cpp	# 
|------	build/						# Build dir holds object, executable and other files that the compiler has produced
|	|------	objects/				# 
|	|	|------	objects.o			# 
|	|------	output/					# 
|		|------	program.elf			# 
|		|------	program.hex			# 
|		|------	program.bin			# 
|		|------	program.lst			# 
|------	Makefile					# The make file is in the root dir to run the project
