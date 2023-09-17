# Lesapp

Til að keyra:

## android & windows

- Sækja android-studio
- Opna android studio og setja upp
- - Platform tools
- - cmd-line
- Sækja java-jdk version 11
- Setja inn enviroment variables
- - '.../android/platform-tools'
- - '.../android/cmdline-tools/latest/bin'
- - '.../Java/jdk-11/bin'
- - '.../Java/jdk-11/lib'
- Skrifa inn terminal 'flutter doctor -v' og fylgja því sem beðið er um

Kveikt þarf að vera á simulator eða sími tengdur við tölvu.

Til að Keyra úr terminal:

flutter pub get

flutter run

## android & windows með wsl2

### On Windows:

- Sækja android-studio í windows
- Opna android studio og setja upp
- - Platform tools
- - cmd-line

- Svo til að forwarda skal keyra
- - adb kill-server
- - adb -a nodaemon server
- Ef þú villt debugging opnaðu annað cmd / powershell og gerðu
- - adb -s <emulator you want to debug> reverse tcp:8888 tcp:8888

## WSL

- Sækja skal
- - dart: ">=2.18.0 <3.0.0"
- - flutter: ">=3.3.0"
- - java-jdk version 11
- - adb Platform tools
- - Setja inn enviroment variables
- - '.../android/platform-tools'
- - '.../android/cmdline-tools/latest/bin'
- - '.../Java/jdk-11/bin'
- - '.../Java/jdk-11/lib'
- Skrifa inn terminal 'flutter doctor -v' og fylgja því sem beðið er um

- Tengjast Websocket á emulator:
- - ADB_SERVER_SOCKET=tcp:172.20.96.1:5037
- Athuga með devices
- - 'adb devices' í WSL og Windows ætti að gefa það sama
- Keyra app í wsl
- - flutter run
    eða
- - flutter run --host-vmservice-port 8888
