# Usage

## Server:
```
read -p 'Sever password: ' SERVER_PASSWORD && SERVER_PASSWORD=${SERVER_PASSWORD:-MY_SSPASSWORD} && echo $SERVER_PASSWORD
read -p 'Sever port number: ' SERVER_PORT && SERVER_PORT=${SERVER_PORT:-14443} && echo $SERVER_PORT
```

* Forward both tcp and udp ports on the router to allow the "-u" option in "ss-redir"
```
docker run -d --restart always -p $SERVER_PORT:8388 -p $SERVER_PORT:8388/udp --name ssr-server lasery/rpi-shadowsocksr:18.07 python server.py \
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
docker run --rm \
  -p 14443:8388 -p 14443:8388/udp \
  --name ssr-server \
  lasery/shadowsocksr \
  python server.py \
  -s 0.0.0.0 \
  -p 8388 \
  -m aes-256-cfb \
  -O origin \
  -k MY_SSPASSWORD
```

- arm32v6
```
git clone git@github.com:laseryuan/docker-rpi-shadowsocksr.git

docker run --rm -p 14443:8388 --name ssr-server lasery/rpi-shadowsocksr python server.py -s 0.0.0.0 -p 8388/udp -p 8388 -m aes-256-cfb -O origin -k MY_SSPASSWORD

docker build -t lasery/rpi-shadowsocksr .
docker tag lasery/rpi-shadowsocksr lasery/rpi-shadowsocksr:18.08
docker push lasery/rpi-shadowsocksr:18.08
```

- amd64
```
docker build -t lasery/shadowsocksr -f Dockerfile.amd64 .

docker tag lasery/shadowsocksr lasery/shadowsocksr:18.11-amd64
docker push lasery/shadowsocksr:18.11-amd64
```

## Multiple Archi
```
DOCKER_CLI_EXPERIMENTAL=enabled
SSR_VERSION=18.11

docker manifest create lasery/shadowsocksr:${SSR_VERSION} lasery/shadowsocksr:${SSR_VERSION}-amd64 lasery/shadowsocksr:${SSR_VERSION}-arm32v6
docker manifest annotate lasery/shadowsocksr:${SSR_VERSION} lasery/shadowsocksr:${SSR_VERSION}-amd64 --arch amd64
docker manifest annotate lasery/shadowsocksr:${SSR_VERSION} lasery/shadowsocksr:${SSR_VERSION}-arm32v6 --arch arm
docker manifest push lasery/shadowsocksr:${SSR_VERSION}

docker manifest inspect lasery/shadowsocksr
```

Set default latest version
```
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
