help:
	@echo make all
	@echo make compile
	@echo make flash

all: flash

compile:
	./compile.sh bleprph

flash: compile
	./flash.sh bleprph
