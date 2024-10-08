TARGETAPP=bleprph

help:
	@echo make all: flash compile
	@echo make compile
	@echo make flash
	@echo make target
	@echo make clean
	@echo "TARGETAPP=[bleprph|blinky|btshell]"

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

clean:
	rm -rf GPATH GRTAGS GTAGS
	rm -rf apps/bleprph/src/GPATH apps/bleprph/src/GRTAGS apps/bleprph/src/GTAGS
	rm -rf bin

debug:
	tmux split-window 'openocd -f "interface/jlink.cfg" -c "transport select swd" -f "target/nrf52.cfg"'
	tmux split-window 'gdb-multiarch ./bin/targets/nrf52_${TARGETAPP}/app/apps/${TARGETAPP}/${TARGETAPP}.elf'
	minicom -D $$(nrfjprog --com | cut - -d " " -f 5)

# Export the firmware created in "flash.sh" inside the current directory.
# This target is meant to be called from the directory where the firmware
# should be exported like the following:
# $ make -f ~/path/to/screaming_channels_nimble/Makefile export
export:
	cp /tmp/mynewt-firmware.hex nimble.hex
