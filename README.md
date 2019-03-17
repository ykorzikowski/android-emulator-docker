## Android Emulator Docker image

### Usage

* Launch, wait and unlock the emulator

        docker run --privileged -v /dev/kvm:/dev/kvm --rm niltonvasques/android-sdk-and-emulator:0.1.5 \
        bash -c "start_emulator && wait_emulator && unlock_emulator"

* Usage with Drone CI

```yml
- name: android-integrationtest
  depends_on: [ clone ]
  image: ykorzikowski/flutter-android-sdk-and-emulator:0.1.0
  privileged: true
  volumes:
    - name: kvm
      path: /dev/kvm
  environment:
    DEVICE_ID: "10.1in WXGA (Tablet)"
    API_LEVEL: "24" # 24-28
  commands:
    - start_emulator && wait_emulator && unlock_emulator
    - flutter drive --target=test_driver/app_full.dart
  cache:
    mount:
      - /drone/.gradle
```

```
Available devices definitions:
id: 0 or "tv_1080p"
id: 1 or "tv_720p"
id: 2 or "wear_round"
id: 3 or "wear_round_chin_320_290"
id: 4 or "wear_square"
id: 5 or "Galaxy Nexus"
id: 6 or "Nexus 10"
id: 7 or "Nexus 4"
id: 8 or "Nexus 5"
id: 9 or "Nexus 5X"
id: 10 or "Nexus 6"
id: 11 or "Nexus 6P"
id: 12 or "Nexus 7 2013"
id: 13 or "Nexus 7"
id: 14 or "Nexus 9"
id: 15 or "Nexus One"
id: 16 or "Nexus S"
id: 17 or "pixel"
id: 18 or "pixel_c"
id: 19 or "pixel_xl"
id: 20 or "2.7in QVGA"
id: 21 or "2.7in QVGA slider"
id: 22 or "3.2in HVGA slider (ADP1)"
id: 23 or "3.2in QVGA (ADP2)"
id: 24 or "3.3in WQVGA"
id: 25 or "3.4in WQVGA"
id: 26 or "3.7 FWVGA slider"
id: 27 or "3.7in WVGA (Nexus One)"
id: 28 or "4in WVGA (Nexus S)"
id: 29 or "4.65in 720p (Galaxy Nexus)"
id: 30 or "4.7in WXGA"
id: 31 or "5.1in WVGA"
id: 32 or "5.4in FWVGA"
id: 33 or "7in WSVGA (Tablet)"
```

```
Pie 	9 	API level 28
Oreo 	8.1.0 	API level 27
Oreo 	8.0.0 	API level 26
Nougat 	7.1 	API level 25
Nougat 	7.0 	API level 24
```
