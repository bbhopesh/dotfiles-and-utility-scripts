#!/bin/bash
my_path=$(readlink -f $0)
cd $(dirname "${my_path}")
./toggle_xdevice.sh Touchpad
