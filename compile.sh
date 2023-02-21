#!/bin/bash

if [[ $# < 1 ]]; then
    echo "Usage: $0 app-name"
    exit
fi

set -e

newt build "nrf52_boot"
newt build "nrf52_$1"
newt create-image "nrf52_$1" 1.0.0
