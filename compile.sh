#!/bin/bash

if [[ $# < 1 ]]; then
    echo "Usage: $0 app-name"
    exit
fi

set -e

newt build "nrf52_boot"
if [[ $(hostname) == "Saren" ]]; then
    newt build "nrf52_$1" --syscfg SC_BD_ADDR_SPOOF='"cafecafecafe"'
    newt create-image "nrf52_$1" 1.0.0 --syscfg SC_BD_ADDR_SPOOF='"cafecafecafe"'
elif [[ $(hostname) == "Reaper" ]]; then
    newt build "nrf52_$1" --syscfg SC_BD_ADDR_SPOOF='"00190e1979d8"'
    newt create-image "nrf52_$1" 1.0.0 --syscfg SC_BD_ADDR_SPOOF='"00190e1979d8"'
fi
