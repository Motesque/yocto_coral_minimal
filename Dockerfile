FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get install -y gawk wget git diffstat unzip texinfo gcc-multilib \
        build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
        xz-utils debianutils iputils-ping libsdl1.2-dev xterm
RUN  apt-get install -y  autoconf libtool libglib2.0-dev libarchive-dev python-git \
        sed cvs subversion coreutils texi2html docbook-utils python-pysqlite2 \
        help2man make gcc g++ desktop-file-utils libgl1-mesa-dev libglu1-mesa-dev \
        mercurial automake groff curl lzop asciidoc u-boot-tools dos2unix mtd-utils pv \
        libncurses5 libncurses5-dev libncursesw5-dev libelf-dev zlib1g-dev bc rename rsync

RUN apt-get install -y tmux

# The Yocto build fails, if the Linux system does not configure a UTF8-capable locale
RUN apt-get install -y  locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

# install repo
RUN mkdir ${HOME}/bin \ 
    && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo \
    && chmod a+x /usr/local/bin/repo 


ENV USER_NAME motesque
# set shared user between host and docker container. This is needed to access host folders, while
# not running root in the container (b/c yocto does not allow that)
ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME && \
    useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

RUN apt-get install sudo -y \
    && usermod -aG sudo $USER_NAME

# make sure sudo works without password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# from now on, use non-root user
USER $USER_NAME

RUN git config --global user.name "motesque" \
    && git config --global user.email "support@motesque.com"

ENV HOME_DIR /home/$USER_NAME
ENV BUILD_DIR /home/$USER_NAME/build

RUN mkdir -p $BUILD_DIR

WORKDIR $HOME_DIR

ARG TAG_NAME=dunfell-fslc-5.4-2.1.x-mx8mm-v1.1 

RUN repo init -u https://github.com/varigit/variscite-bsp-platform.git -b refs/tags/${TAG_NAME} \
    && repo sync -j4

RUN git clone git://github.com/kraj/meta-clang.git -b dunfell sources/meta-clang

COPY scripts $HOME_DIR
