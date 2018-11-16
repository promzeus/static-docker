#!/usr/bin/env docker build --compress -t pvtmert/tmux:static -f

FROM debian:stable

ENV CC=clang
ENV DIR=tmux

#VOLUME /data
WORKDIR /data

RUN apt update && apt install -y automake build-essential clang libevent-dev git pkg-config libncurses5-dev

RUN git clone -q --progress --depth 1 https://github.com/tmux/tmux.git $DIR
RUN (cd $DIR; bash autogen.sh) && $DIR/configure --enable-static
CMD make -C . -j $(nproc) && ./tmux