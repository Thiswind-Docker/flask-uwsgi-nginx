#!/bin/bash

nginx -g "daemon on;"
uwsgi --ini ./uwsgi_config.ini
