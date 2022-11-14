#!/bin/bash

if [[ $# < 1 ]]; then
    echo "Usage: $0 app-name"
    exit
fi

btldr=$(find . -name mynewt.elf.bin)
app=$(find . -name "$1".hex)

echo "BTLDR=$btldr"
echo "APP=$app"
read -p "Continue?"

Bin2Hex.py -b "$btldr" -o /tmp/mynewt-bootloader.hex
mergehex -m /tmp/mynewt-bootloader.hex "$app" -o /tmp/mynewt-firmware.hex
nrfjprog -f nrf52 --program /tmp/mynewt-firmware.hex --chiperase
nrfjprog -f nrf52 --reset
