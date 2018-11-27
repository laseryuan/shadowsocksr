# Usage

## Server:
```
read -p 'Sever password: ' SERVER_PASSWORD && SERVER_PASSWORD=${SERVER_PASSWORD:-MY_SSPASSWORD} && echo $SERVER_PASSWORD
read -p 'Sever port number: ' SERVER_PORT && SERVER_PORT=${SERVER_PORT:-14443} && echo $SERVER_PORT
```

* Forward both tcp and udp ports on the router to allow the "-u" option in "ss-redir"
```
docker run -d --restart always \
  --name ssr-server \
  -p $SERVER_PORT:8388 -p $SERVER_PORT:8388/udp \
  lasery/shadowsocksr \
  python server.py \
  -s 0.0.0.0 \
  -p 8388 \
  -m aes-256-cfb \
  -O origin \
  -k $SERVER_PASSWORD
```

## Client:
```
read -p 'Server name: ' SERVER_NAME && SERVER_NAME=${SERVER_NAME:-changeme.com} && echo $SERVER_NAME
read -p 'Sever password: ' SERVER_PASSWORD && SERVER_PASSWORD=${SERVER_PASSWORD:-MY_SSPASSWORD} && echo $SERVER_PASSWORD
read -p 'Server port number: ' SERVER_PORT && SERVER_PORT=${SERVER_PORT:-14443} && echo $SERVER_PORT
read -p 'Socks5 port number: ' SOCKS_PORT && SOCKS_PORT=${SOCKS_PORT:-1080} && echo $SOCKS_PORT

docker run -d --restart always -p $SOCKS_PORT:1080 --name ssr-client lasery/rpi-shadowsocksr:18.07 python local.py \
-l 1080 -m aes-256-cfb -b 0.0.0.0 \
-O origin \
-s $SERVER_NAME -p $SERVER_PORT -k $SERVER_PASSWORD
```

# Development
```
SSR_VERSION=18.11

docker run -it --rm \
  --name ssr-server \
  -p 14443:8388 -p 14443:8388/udp \
  -v $(pwd)/docker-entrypoint.sh:/docker-entrypoint.sh \
  lasery/shadowsocksr \
  bash

  python server.py \
  -s 0.0.0.0 \
  -p 8388 \
  -m aes-256-cfb \
  -O origin \
  -k MY_SSPASSWORD
```

- arm32v6
```
docker build -t lasery/shadowsocksr --build-arg python=resin/raspberry-pi-python:3.7.0-stretch-20181123 .

docker tag lasery/shadowsocksr lasery/shadowsocksr:${SSR_VERSION}-arm32v6
docker push lasery/shadowsocksr:${SSR_VERSION}-arm32v6
```

- amd64
```
docker build -t lasery/shadowsocksr --build-arg python=python:3.7.1-stretch .

docker tag lasery/shadowsocksr lasery/shadowsocksr:${SSR_VERSION}-amd64
docker push lasery/shadowsocksr:${SSR_VERSION}-amd64
```

## Multiple Archi
```
export DOCKER_CLI_EXPERIMENTAL=enabled

docker manifest create lasery/shadowsocksr lasery/shadowsocksr:${SSR_VERSION}-amd64 lasery/shadowsocksr:${SSR_VERSION}-arm32v6
docker manifest annotate lasery/shadowsocksr lasery/shadowsocksr:${SSR_VERSION}-amd64 --arch amd64
docker manifest annotate lasery/shadowsocksr lasery/shadowsocksr:${SSR_VERSION}-arm32v6 --arch arm
docker manifest push lasery/shadowsocksr
```

## Test
curl --proxy socks5://localhost:1080 https://check.torproject.org/api/ip
curl --proxy socks5h://localhost:1080 https://check.torproject.org/api/ip # Transparent DNS

# Reference
- shadowsocksr
https://github.com/shadowsocksrr

- shadowsocks
https://github.com/shadowsocks
