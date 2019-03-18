#!/bin/bash
echo "no" | avdmanager create avd -f -n test -k "${SYSTEM_IMAGE}" --device "${DEVICE_ID}"
emulator64-x86 -avd test -noaudio -no-window -gpu off -verbose -qemu -usbdevice tablet &
