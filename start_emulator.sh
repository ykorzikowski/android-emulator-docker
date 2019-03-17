#!/bin/bash
echo "no" | avdmanager create avd -f -n test -k "system-images;android-${API_LEVEL};google_apis;x86_64" --device ${DEVICE_ID}
emulator64-x86 -avd test -noaudio -no-window -gpu off -verbose -qemu -usbdevice tablet &
