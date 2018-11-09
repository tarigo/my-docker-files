#!/bin/sh

xhost +SI:localuser:$(id -un)

mkdir -p .gradle
mkdir -p .AndroidStudio3.2

docker run -ti -e DISPLAY=:0 \
       --net=host \
       --device /dev/kvm \
       -v /dev/bus/usb:/dev/bus/usb \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $(dirname `pwd`):/home/developer/Development \
       -v `pwd`/.gradle:/home/developer/.gradle \
       -v `pwd`/.AndroidStudio3.2:/home/developer/.AndroidStudio3.2 \
       -v $HOME/.ssh:/home/developer/.ssh \
       -v $HOME/.gitconfig:/home/developer/.gitconfig \
       tarigo/android-dev-env bash
