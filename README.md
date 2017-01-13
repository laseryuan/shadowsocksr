# Usage
PORT=[port_number]  
PASSWORD=[ssr_password]  
docker run -d --restart always -p $PORT:443 --name shadowsocksr lasery/rpi-shadowsocksr python server.py -p 443 -k $PASSWORD -m aes-256-cfb -O origin  

# Development
docker build -t lasery/rpi-shadowsocksr .  
docker push lasery/rpi-shadowsocksr  
