FROM debian:11-slim
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define environment vars
# Set PERL_USE_UNSAFE_INC to make Debian 9 latex2html work

ENV WORK_DIR=/data/work \
    SHARED_DIR=/data/shared/fli4l \
    DEBIAN_FRONTEND=noninteractive \
    PERL_USE_UNSAFE_INC=1 \
    LC_ALL=en_US.UTF-8 \
    TZ='Europe/Berlin'

# Mount point for development workspace
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

# Mount point for shared resources like source archives etc
RUN mkdir -p ${SHARED_DIR}
VOLUME ${SHARED_DIR}

RUN apt-get update -y \
 && apt-get upgrade -y \
 && apt autoclean

RUN apt-get install -y --no-install-recommends \
    bc \
    binutils \
    bison \
    bsdmainutils \
    build-essential \
    ca-certificates \
    cpio \
    elfutils \
    file \
    flex \
    gcc-multilib \
    g++-multilib \
    git \
    kmod \
    libncurses5-dev \
    libc6-dev-i386 \
    libelf-dev \
    libssl-dev \
    locales \
    make \
    man-db \
    mc \
    openssh-client \
    procps \
    python \
    rsync \
    subversion \
    unzip \
    uuid-dev \
    wget \
 && apt autoclean


# Set locale to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales \
 && /usr/sbin/update-locale LANG=en_US.UTF-8

# Set timezone to Europe/Berlin
RUN echo $TZ > /etc/timezone && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

