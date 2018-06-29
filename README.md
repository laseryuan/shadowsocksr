# Usage
read -p 'port number: ' PORT && echo $PORT
read -p 'ssr password: ' PASSWORD && echo $PASSWORD

docker run -d --restart always -p $PORT:443 --name ssrr lasery/rpi-shadowsocksr:armv6hf python server.py -p 443 -k $PASSWORD -m aes-256-cfb -O origin

# Development

## armv6hf
docker build -t lasery/rpi-shadowsocksr:armv6hf -f Dockerfile.armv6hf .
docker push lasery/rpi-shadowsocksr:armv6hf

## raspbian
docker build -t lasery/rpi-shadowsocksr .
docker push lasery/rpi-shadowsocksr
