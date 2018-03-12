#!/bin/bash

NGINX_CONF_NAME="uwsgi.nginx"

rm -f $NGINX_CONF_NAME
rm -f /etc/nginx/sites-enabled/$NGINX_CONF_NAME

cmd="sed 's?PATH?$(pwd)?g' uwsgi.nginx.template"
eval "$cmd" > $NGINX_CONF_NAME 

rm -f /etc/nginx/conf.d/default.conf
ln -s $(pwd)/$NGINX_CONF_NAME /etc/nginx/conf.d/default.conf

