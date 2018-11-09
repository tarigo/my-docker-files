FROM ubuntu:18.04

MAINTAINER Igor Tarasov <i.s.tarasov@gmail.com>

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y build-essential git wget unzip sudo \
                       libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 \
                       libbz2-1.0:i386 libxrender1 libxtst6 libxi6 \
                       libfreetype6 libxft2 qemu qemu-kvm libvirt-clients \
                       libvirt-daemon-system bridge-utils virt-manager \
                       libnotify4 libglu1 libqt5widgets5 openjdk-8-jdk xvfb
RUN apt-get install -y cmake
RUN apt-get install -y emacs tmux
RUN apt-get install -y golang
RUN apt-get install -y protobuf-compiler protobuf-compiler-grpc
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV USERNAME developer

RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        # Replace 1000 with your user/group id
        usermod  --uid 1000 $USERNAME && \
        groupmod --gid 1000 $USERNAME

RUN adduser $USERNAME libvirt
RUN adduser $USERNAME kvm

USER developer
WORKDIR /home/$USERNAME

ENV ANDROID_HOME=/home/$USERNAME/android-sdk
ENV ANDROID_STUDIO=/home/$USERNAME/android-studio

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin

### Install Android SDK
RUN wget -O sdk.zip -nv https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk.zip -d android-sdk && rm sdk.zip
RUN mkdir .android && touch .android/repositories.cfg
RUN sdkmanager --update
RUN echo y | sdkmanager "platform-tools"

RUN echo y | sdkmanager    \
    "platforms;android-28" \
    "platforms;android-27" \
    "platforms;android-26"

RUN echo y | sdkmanager  \
    "build-tools;28.0.3" \
    "build-tools;28.0.2" \
    "build-tools;27.0.3" \
    "build-tools;26.0.3"

RUN echo y | sdkmanager                                                                 \
    "extras;android;m2repository"                                                       \
    "extras;google;m2repository"                                                        \
    "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"        \
    "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"

RUN echo y | sdkmanager "cmake;3.6.4111459"
RUN echo y | sdkmanager "ndk-bundle"

RUN echo y | sdkmanager "add-ons;addon-google_apis-google-24"
RUN echo y | sdkmanager "patcher;v4"

RUN echo y | sdkmanager  \
    "sources;android-28" \
    "sources;android-27"

RUN echo y | sdkmanager \
    "emulator"          \
    "system-images;android-28;google_apis_playstore;x86"

### Install Android Studio
ENV PATH $PATH:$ANDROID_STUDIO/bin
RUN wget -nv https://dl.google.com/dl/android/studio/ide-zips/3.2.0.26/android-studio-ide-181.5014246-linux.zip -O studio.zip
RUN unzip studio.zip && rm studio.zip

