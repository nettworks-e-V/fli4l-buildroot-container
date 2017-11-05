FROM debian:stretch
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define environment vars
ENV WORK_DIR=/data/work \
    DEBIAN_FRONTEND=noninteractive

# Mount point for Edomi backups
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

RUN apt-get update -y \
 && apt-get upgrade -y
RUN apt-get install -y \
    locales \
    mc \
    git \
    subversion \
    elfutils \
    make \
    binutils \
    build-essential \
    cpio \
    python \
    bc \
    wget \
    libncurses5-dev

# Set locale to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales \
 && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
