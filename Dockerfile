ARG python

FROM $python

ADD ./ssrr-3.2.2.tar.gz /tmp/
RUN mv /tmp/shadowsocksr-3.2.2 /root/shadowsocksr

RUN cd /root/shadowsocksr && bash initcfg.sh

# Development
RUN apt-get update
RUN apt-get install -y \
  curl \
  dnsutils \
  netcat \
  --no-install-recommends

RUN useradd -ms /bin/bash shadowsocksr

RUN mv /root/shadowsocksr /home/shadowsocksr/app
RUN chown shadowsocksr:shadowsocksr -R /home/shadowsocksr/app

USER shadowsocksr

WORKDIR /home/shadowsocksr/app/shadowsocks/

COPY --chown=shadowsocksr config.json ./../user-config.json

COPY --chown=shadowsocksr docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
