# Usage

Configuration:
```
read -p 'port number: ' SERVER_PORT && SERVER_PORT=${SERVER_PORT:-14443} && echo $SERVER_PORT
read -p 'port number: ' CLIENT_PORT && CLIENT_PORT=${CLIENT_PORT:-1080} && echo $CLIENT_PORT
```

Server:
```
docker run -d --restart always -p $SERVER_PORT:8388 --name ssr-server -v $PWD/server.json:/root/shadowsocksr/config.json lasery/rpi-shadowsocksr:20180723 python server.py
```

Client:
```
docker run -d --restart always -p $CLIENT_PORT:1080 --name ssr-client -v $PWD/client.json:/root/shadowsocksr/config.json lasery/rpi-shadowsocksr:20180723 python local.py
```

# Development
```
git clone git@github.com:laseryuan/docker-rpi-shadowsocksr.git

docker tag lasery/rpi-shadowsocksr lasery/rpi-shadowsocksr:20180723
docker push lasery/rpi-shadowsocksr:20180723
```

# Reference

## shadowsocksr
https://github.com/shadowsocksrr

## shadowsocks
https://github.com/shadowsocks
