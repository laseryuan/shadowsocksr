FROM resin/raspberry-pi-python

ADD ./ssrr-3.2.2.tar.gz /tmp/
RUN mv /tmp/shadowsocksr-3.2.2 /root/shadowsocksr

RUN cd /root/shadowsocksr && bash initcfg.sh

WORKDIR /root/shadowsocksr/shadowsocks
