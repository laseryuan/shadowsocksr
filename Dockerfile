FROM resin/rpi-raspbian:jessie-20170111

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install git python

RUN git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git

RUN cd shadowsocksr && bash initcfg.sh

WORKDIR /shadowsocksr/shadowsocks
