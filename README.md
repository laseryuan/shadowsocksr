# Usage

Server:
```
read -p 'Sever password: ' SERVER_PASSWORD && SERVER_PASSWORD=${SERVER_PASSWORD:-MY_SSPASSWORD} && echo $SERVER_PASSWORD
read -p 'Sever port number: ' SERVER_PORT && SERVER_PORT=${SERVER_PORT:-14443} && echo $SERVER_PORT

docker run -d --restart always -p $SERVER_PORT:8388 --name ssr-server lasery/rpi-shadowsocksr:20180723 python server.py \
-s 0.0.0.0 -p 8388 -m aes-256-cfb \
-O origin \
-k $SERVER_PASSWORD
```

Client:
```
read -p 'Server name: ' SERVER_NAME && SERVER_NAME=${SERVER_NAME:-changeme.com} && echo $SERVER_NAME
read -p 'Sever password: ' SERVER_PASSWORD && SERVER_PASSWORD=${SERVER_PASSWORD:-MY_SSPASSWORD} && echo $SERVER_PASSWORD
read -p 'Server port number: ' SERVER_PORT && SERVER_PORT=${SERVER_PORT:-14443} && echo $SERVER_PORT
read -p 'Socks5 port number: ' SOCKS_PORT && SOCKS_PORT=${SOCKS_PORT:-1080} && echo $SOCKS_PORT

docker run -d --restart always -p $SOCKS_PORT:1080 --name ssr-client lasery/rpi-shadowsocksr:20180723 python local.py \
-l 1080 -m aes-256-cfb -b 0.0.0.0 \
-O origin \
-s $SERVER_NAME -p $SERVER_PORT -k $SERVER_PASSWORD
```

# Test
curl --proxy socks5h://localhost:1080 https://check.torproject.org/api/ip

# Development
```
git clone git@github.com:laseryuan/docker-rpi-shadowsocksr.git

docker build -t lasery/rpi-shadowsocksr .
docker tag lasery/rpi-shadowsocksr lasery/rpi-shadowsocksr:20180723
docker push lasery/rpi-shadowsocksr:20180723
```

# Reference

## shadowsocksr
https://github.com/shadowsocksrr

## shadowsocks
https://github.com/shadowsocks
