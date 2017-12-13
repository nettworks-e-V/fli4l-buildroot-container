FROM debian:stretch
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG DEVELOP_USER=developer
ARG DEVELOP_PASS=developer
ARG UID="1011"
ARG GID="1011"

# Define environment vars
ENV WORK_DIR=/data/work \
    SHARED_DIR=/data/shared/fli4l \
    DEBIAN_FRONTEND=noninteractive

# Mount point for development workspace
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

# Mount point for shared resources like source archives etc
RUN mkdir -p ${SHARED_DIR}
VOLUME ${SHARED_DIR}

# Setup develop account
# Create working directory
# Change user UID and GID
# Run Container with ${DEVELOP_USER}
RUN groupadd --gid ${GID} ${DEVELOP_USER} \
 && useradd --create-home --home-dir /home/${DEVELOP_USER} --shell /bin/bash --uid ${UID} --gid ${GID} ${DEVELOP_USER} \
 && echo "${DEVELOP_USER}:${DEVELOP_USER}" | chpasswd \
 && chown ${DEVELOP_USER}:${DEVELOP_USER} /home/${DEVELOP_USER} -R \
 && ulimit -v unlimited
USER ${DEVELOP_USER}

RUN apt-get update -y \
 && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
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
    libncurses5-dev \
    uuid-dev \
    man-db \
    bsdmainutils \
    file \
    unzip \
    rsync \
    procps \
    kmod \
    openssh-client \
    gcc-multilib \
    g++-multilib \
    libc6-dev-i386 \
    ca-certificates

# Set locale to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales \
 && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
