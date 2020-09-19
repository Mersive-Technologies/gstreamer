FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y python3-wheel ninja-build libmount-dev python3-distro
RUN apt-get install -y python3-pip python3 git build-essential sudo
RUN apt-get install -y autotools-dev automake autoconf libtool g++ autopoint make cmake bison flex yasm pkg-config gtk-doc-tools libxv-dev \
     libx11-dev libpulse-dev python3-dev texinfo gettext build-essential pkg-config doxygen curl libxext-dev libxi-dev x11proto-record-dev \
     libxrender-dev libgl1-mesa-dev libxfixes-dev libxdamage-dev libxcomposite-dev libasound2-dev libxml-simple-perl dpkg-dev debhelper \
     build-essential devscripts fakeroot transfig gperf libdbus-glib-1-dev wget glib-networking libxtst-dev libxrandr-dev libglu1-mesa-dev \
     libegl1-mesa-dev git subversion xutils-dev intltool ccache python3-setuptools
RUN apt-get install -y libpython2.7 libpython2.7-dev python-dev python2.7-dev libfuse2 libselinux1-dev libsepol1-dev fuse chrpath \
    libfuse-dev libssl-dev libx11-xcb-dev nasm

RUN pip3 install meson  

RUN git clone https://gitlab.freedesktop.org/gstreamer/cerbero && \
    cd cerbero && \
    git checkout 1.17.90 && \
    ./cerbero-uninstalled -c config/cross-android-arm64.cbc bootstrap

RUN apt-get install -y nano

RUN cd cerbero && \
    sed -i.bak -e 's/-Wl,-dynamic-linker,\/system\/bin\/linker//g' /cerbero/config/android.config && \
    ./cerbero-uninstalled -c config/cross-android-arm64.cbc build gstreamer-1.0

