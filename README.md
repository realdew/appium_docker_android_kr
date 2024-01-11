# Appium Docker Android - Korean Setting
Appium 공식 Docker Android 이미지에 대한 한국어/시각 커스텀 이미지입니다.

Orignated from: https://hub.docker.com/r/appium/appium

Orignated from: https://github.com/appium/appium-docker-android/tree/master

이 이미지의 자세한 설명과 사용법은 https://github.com/appium/appium-docker-android/tree/master 를 참고하세요.




## Base Image
- appium/appium:latest


## Base Image와의 차이점
1. 한글 설정이 되어 있습니다(ko_KR.UTF-8).
2. 한국 시각으로 timezone이 설정되어 있습니다(Asia/Seoul).
3. appium log에서 타임스탬프가 한국 시간으로 표시됩니다(Asia/Seoul).


## Build

```
docker build -t realdew/appium_docker_android_kr:0.1 -f ./Dockerfile .
```

## Usage

### 1. 호스트 머신에서 안드로이드 디바이스를 연결합니다.

### 2. `lsusb`를 사용하여 연결된 디바이스의 USB Bus를 확인합니다.
```
lee@lee-T303UA:~$ lsusb
Bus 004 Device 003: ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit Ethernet
Bus 004 Device 002: ID 0bda:0411 Realtek Semiconductor Corp. Hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 003: ID 1a40:0101 Terminus Technology Inc. Hub
Bus 003 Device 006: ID 04e8:6860 Samsung Electronics Co., Ltd Galaxy A5 (MTP)
Bus 003 Device 002: ID 0bda:5411 Realtek Semiconductor Corp. RTS5411 Hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 8087:0a2a Intel Corp. Bluetooth wireless interface
Bus 001 Device 002: ID 04f2:b5b1 Chicony Electronics Co., Ltd USB2.0 2M UVC WebCam
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
lee@lee-T303UA:~
```
위의 경우에, `Galaxy A5` 디바이스가 `Bus 003 Device 003`에 연결되어 있음을 확인할 수 있습니다.

### 3. Docker를 실행합니다.

#### 3.1. 특정 디바이스에만 연결
`--device` 옵션을 사용하여 특정 디바이스에 대해서만 appium을 연결할 수 있습니다.
```
docker run -d -p 4723:4723 --device /dev/bus/usb/003/003:/dev/bus/usb/003/003 -v ~/.android:/root/.android -v ~/appium_log:/var/log/ --name appium_003 appium_docker_android_kr:0.1
```
이 경우, appium 서버는 `/dev/bus/usb/003/003`에 연결된 디바이스에 대해서만 작동합니다.


#### 3.2. 특정 USB 버스에 접속된 모든 디바이스에 연결
특정 USB Bus에 접속된 모든 디바이스에 대해서 appium을 연결하려면 다음과 같이 할 수 있습니다.
```
docker run --privileged -d -p 4723:4723 -v /dev/bus/usb/003:/dev/bus/usb/003 -v ~/.android:/home/androidusr/.android -v ~/appium_log:/var/log/ --name appium-container appium_docker_android_kr:0.1

docker exec -it appium-container bash
```
이 경우, appium 서버는 `/dev/bus/usb/003`에 접속된 모든 디바이스에 대해 작동될 수 있습니다.

#### 3.3. 모든 USB 버스에 접속된 모드 디바이스에 연결
USB에 접속된 모든 디바이스에 대하여 appium을 연결합니다.
```
docker run --privileged -d -p 4723:4723 -v /dev/bus/usb:/dev/bus/usb -v ~/.android:/home/androidusr/.android -v ~/appium_log:/var/log/ --name appium-container appium_docker_android_kr:0.1
```
이 경우, appium 서버는 `/dev/bus/usb`에 접속된 모든 디바이스에 대하여 작동될 수 있습니다.


## Tips
`adb` 명령 실행
```
docker exec -it appium_003 adb devices
```

