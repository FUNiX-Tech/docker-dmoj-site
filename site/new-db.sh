#!/bin/bash

echo "yes" | /projects/dmoj/site/make_style.sh
/projects/dmoj/venv/bin/python3 /projects/dmoj/site/manage.py collectstatic
/projects/dmoj/venv/bin/python3 /projects/dmoj/site/manage.py compilemessages 
/projects/dmoj/venv/bin/python3 /projects/dmoj/site/manage.py compilejsi18n
/projects/dmoj/venv/bin/python3 /projects/dmoj/site/manage.py makemigrations funix
/projects/dmoj/venv/bin/python3 /projects/dmoj/site/manage.py migrate
/projects/dmoj/venv/bin/python3 /projects/dmoj/site/manage.py loaddata navbar 
/projects/dmoj/venv/bin/python3 /projects/dmoj/site/manage.py loaddata language_all 
/projects/dmoj/venv/bin/python3 /projects/dmoj/site/manage.py loaddata demo

service memcached start
service redis-server start
service nginx start

/usr/bin/supervisord -n
service supervisor restart all

