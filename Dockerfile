FROM appium/appium:latest


ENV TZ Asia/Seoul
ARG DEBIAN_FRONTEND=noninteractive

# locale 및 tzdata 설치
RUN sudo apt-get -qqy update && \
    sudo apt-get -qqy --no-install-recommends install locales tzdata && \
    sudo apt-get autoremove --purge -y && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    sudo apt-get clean

# locale 설정
RUN sudo locale-gen ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8
ENV LANG ko_KR.UTF-8

# timezone 설정
RUN sudo ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# appium server 로그의 timestamp를 local timezone으로 세팅
ENV APPIUM_ADDITIONAL_PARAMS --local-timezone
