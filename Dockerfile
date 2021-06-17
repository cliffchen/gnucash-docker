FROM debian:sid
MAINTAINER Cliff Chen

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install build-essential autoconf automake libtool m4 make cmake ninja-build googletest libtool libltdl-dev libglib2.0 libglib2.0-dev icu-devtools libicu-dev libboost-all-dev guile-2.2 guile-2.2-dev libxml2 libxml++2.6-dev libxml2-utils libxslt1.1 libxslt1-dev xsltproc texinfo libsecret-1-0 gtk+3.0 libgtk-3-dev libwebkit2gtk-4.0-37 libwebkit2gtk-4.0-dev python3-pytest wget gettext aqbanking-tools libaqbanking-dev gwenhywfar-tools libgwenhywfar79 libgwenhywfar-core-dev libofx-dev libdbi1 libdbi-dev libdbd-pgsql libdbd-mysql libdbd-sqlite3 git swig libgwengui-gtk3-dev

# gtest build
ENV HOME=/root
RUN mkdir -p $HOME/.local/src
WORKDIR $HOME/.local/src
RUN git clone https://github.com/google/googletest.git && mkdir -p $HOME/.local/src/googletest/mybuild
WORKDIR $HOME/.local/src/googletest/mybuild
RUN cmake -DBUILD_GMOCK=ON ../ && make
ENV GTEST_ROOT=$HOME/.local/src/googletest

# fix python lib folder
WORKDIR /usr/local/lib
RUN rm -rf python3.9 && ln -s python3 python3.9

# gnucash build
WORKDIR /root
RUN wget https://downloads.sourceforge.net/sourceforge/gnucash/gnucash-4.5.tar.bz2 && bzcat gnucash-4.5.tar.bz2 | tar -C /root -xvf - && mkdir build-gnucash-4.5
WORKDIR /root/build-gnucash-4.5
RUN cmake -DCMAKE_PREFIX_PATH=$HOME/.local -DWITH_PYTHON=ON ../gnucash-4.5 && make && make install
