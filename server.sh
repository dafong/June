#!/bin/sh
[[ $# -lt 1 ]] && echo "useage sh server.sh start|stop|reload" && exit;
cmd=$1

case $cmd in
    start)
        nginx -p `pwd`/ -c "./conf/nginx.conf"
    ;;
    stop)
        nginx -p `pwd`/ -s stop
    ;;
    reload)
        nginx -p `pwd`/ -s reload
    ;;
esac
