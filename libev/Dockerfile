FROM resin/raspberry-pi-debian:stretch-20180626
RUN apt-get update && apt-get -y upgrade

RUN apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev asciidoc xmlto
RUN apt-get install --no-install-recommends -y libz-dev

ADD ./ssr-libev-2.5.3.tar.gz /tmp/
RUN mv /tmp/shadowsocksr-libev-2.5.3 /root/shadowsocksr-libev

WORKDIR /root/shadowsocksr-libev

RUN ./configure && make
RUN make install

