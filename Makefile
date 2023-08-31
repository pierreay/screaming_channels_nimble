# blinky
# bleprph
TARGETAPP=bleprph

help:
	@echo make all: flash compile
	@echo make compile
	@echo make flash
	@echo make target
	@echo TARGETAPP=bleprph

all: flash

compile:
	./compile.sh ${TARGETAPP}

flash: compile
	./flash.sh ${TARGETAPP}

target:
	newt target create nrf52_${TARGETAPP}
	newt target set nrf52_${TARGETAPP} app=apps/${TARGETAPP}
	newt target set nrf52_${TARGETAPP} bsp=@apache-mynewt-core/hw/bsp/nordic_pca10040
	newt target set nrf52_${TARGETAPP} build_profile=debug
