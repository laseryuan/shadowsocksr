# Usage
```
read -p 'port number: ' PORT && PORT=${PORT:-14443} && echo $PORT
read -p 'ssr password: ' PASSWORD && PASSWORD=${PASSWORD:-MY_SSPASSWORD} && echo $PASSWORD

docker run -d --restart always -p $PORT:443 --name ssrr lasery/rpi-shadowsocksr:20180723 python server.py -p 443 -k $PASSWORD -m aes-256-cfb -O origin
```

# Development
git clone git@github.com:laseryuan/docker-rpi-shadowsocksr.git
https://github.com/shadowsocksrr/shadowsocksr

docker tag lasery/rpi-shadowsocksr lasery/rpi-shadowsocksr:20180723
docker push lasery/rpi-shadowsocksr:20180723
```

