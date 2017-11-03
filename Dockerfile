FROM debian:stretch
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define build arguments
ARG SVN_ACCOUNT=anonymous
ARG SVN_PASS=''

# Define environment vars
ENV SVN_ACCOUNT=${SVN_ACCOUNT} \
    SVN_PASS=${SVN_PASS} \
    SVN_CHECKOUT_DIR=/opt/svn-checkout

# Mount point for Edomi backups
VOLUME ${SVN_CHECKOUT_DIR}

RUN apt-get update -y
RUN apt-get upgrade -y
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
ENV DEBIAN_FRONTEND noninteractive
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales \
 && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
