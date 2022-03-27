#!/bin/bash

echo "Attaching bluetooth"
btattach -B /dev/ttyAMA0 -P bcm -S 115200 -N && echo "Ok"
bluetoothctl list >> /dev/null && echo 'List successful'
bluetoothctl power on >> /dev/null && echo 'Powered on'
bluetoothctl
