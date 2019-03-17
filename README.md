## Android Emulator Docker image

### Usage

* Launch, wait and unlock the emulator

        docker run --privileged -v /dev/kvm:/dev/kvm --rm niltonvasques/android-sdk-and-emulator:0.1.5 \
        bash -c "start_emulator && wait_emulator && unlock_emulator"

* Usage with Drone CI

```yml
build:
  image: ykorzikowski/flutter-android-sdk-and-emulator:0.1.0
  privileged: true
  commands:
    - cp -a /drone/.gradle /root/ && rm -Rf /drone/.gradle
    - start_emulator && wait_emulator
    - flutter build
    - unlock_emulator
    - flutter drive --target=test_driver/app_full.dart
    - cp -a /root/.gradle /drone/
cache:
  mount:
    - /drone/.gradle
```
