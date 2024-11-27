# syntax=docker/dockerfile:1

FROM ubuntu:22.04
RUN apt-get update

################
# Dependencies #
################

# MPF Core
RUN apt-get install \
  build-essential git \
  python3-pip python3-venv \
  zlib1g-dev libjpeg-dev libtiff5-dev libtiff5-dev -y

# MPF Media Controller
RUN apt-get install \
  libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev \
  libsdl2-mixer-dev gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-base gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly libgstreamer1.0-dev \
  libxine2-ffmpeg libsmpeg-dev libswscale-dev \
  libavformat-dev libavcodec-dev libjpeg-dev libtiff5-dev \
  libx11-dev libmtdev-dev build-essential libgl1-mesa-dev \
  libgles2-mesa-dev pulseaudio lsb-release \
  libgl1-mesa-dri libavfilter-dev libavdevice-dev -y

###########
# Install #
###########

VOLUME ["/usr/src/machine"]
WORKDIR /usr/src/build

RUN alias python=python3
# RUN export PATH=$PATH:/usr/src/app/penv/bin
# RUN python3 -m venv penv
RUN pip install --upgrade \
  pip setuptools wheel build coveralls pillow
RUN pip install --upgrade Cython==0.29.36

# Install MPF
RUN pip install mpf==0.57.0
ENV KIVY_GL_BACKEND=sdl2
RUN pip install mpf-mc==0.57.0
RUN pip install mpf-monitor

WORKDIR /usr/src/machine
RUN mpf --version

ENV DISPLAY=:0
ENV DEBIAN_FRONTEND=noninteractive

# Add a user (to avoid running GUI apps as root)
RUN useradd -m docker && echo "docker:docker" | chpasswd \
  && adduser docker sudo
RUN usermod -aG video docker
USER docker
