#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    server)
      check-restart
      run-server
      ;;
    help)
      run-help
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run-server() {
    python server.py
}

run-help() {
  echo docker run -it --restart always \
    --name ssr-server \
    -p {SERVER_PORT\|14443}:8388 -p {SERVER_PORT\|14443}:8388/udp \
    lasery/shadowsocksr \
    server
}

check-restart() {
  # Run once, hold otherwise
  if [ -f "already_ran" ]; then
    echo "Already ran the Entrypoint once. Using the exist setting."
    return
  fi

  read-param
  write-config
  touch already_ran
}

read-param() {
  echo "The server will work on port 8388, please expose this port from docker"
  read -p 'Sever password (default: MY_SSPASSWORD): ' SERVER_PASSWORD && SERVER_PASSWORD=${SERVER_PASSWORD:-MY_SSPASSWORD} && echo $SERVER_PASSWORD
  read -p 'Method (default: aes-256-cfb): ' METHOD && METHOD=${METHOD:-aes-256-cfb} && echo $METHOD
  read -p 'PROTOCOL (default: origin): ' PROTOCOL && PROTOCOL=${PROTOCOL:-origin} && echo $PROTOCOL
}

write-config() {
  CONFIG_FILE=../user-config.json
  sed -i "s/<password>/${SERVER_PASSWORD}/" $CONFIG_FILE
  sed -i "s/<method>/${METHOD}/" $CONFIG_FILE
  sed -i "s/<protocol>/${PROTOCOL}/" $CONFIG_FILE
}

main "$@"

