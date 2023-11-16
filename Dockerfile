ARG CUDA_VERSION=12.2.2
ARG UBUNTU_VERSION=22.04
ARG TURBOVNC_VERSION=3.0.3

FROM nvidia/cuda:${CUDA_VERSION}-runtime-ubuntu${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y \
        gettext-base \
        gpg \
        jq \
        psmisc \
        tini \
        wget curl \
        dbus-x11 \
        xauth xinit x11-xserver-utils \
        xdg-utils \
        python3-pip \
        xfce4 xfce4-goodies elementary-xfce-icon-theme \
        xterm xfce4-terminal \
        zsh bash fish tcsh \
        firefox chromium-browser \
  && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/tmp/*

RUN DEB=/tmp/turbovnc_3.0.3_amd64.deb \
  && curl https://versaweb.dl.sourceforge.net/project/turbovnc/3.0.3/turbovnc_3.0.3_amd64.deb > $DEB \
  && dpkg --install $DEB \
  && rm -f $DEB

RUN pip3 install websockify

ENV PATH=/opt/TurboVNC/bin/:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin



