#!/bin/bash
# vim: set noswapfile :

main() {
  case "$1" in
    server)
      read-param
      run-server
      ;;
    *)
      exec "$@"
      ;;
  esac
}

run-server() {
    python server.py \
    -s 0.0.0.0 \
    -p $SERVER_PORT \
    -m aes-256-cfb \
    -O origin \
    -k $SERVER_PASSWORD
}

read-param() {
  read -p 'Sever password (default: MY_SSPASSWORD): ' SERVER_PASSWORD && SERVER_PASSWORD=${SERVER_PASSWORD:-MY_SSPASSWORD} && echo $SERVER_PASSWORD
  read -p 'Sever port number (default: 8388): ' SERVER_PORT && SERVER_PORT=${SERVER_PORT:-8388} && echo $SERVER_PORT
}

main "$@"

