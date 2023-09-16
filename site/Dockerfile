FROM ubuntu:22.04

# install python, pip
RUN apt-get update \
    && apt-get install -y python3-pip python3-dev \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip

# install prerequisite: mariadb-server 
RUN apt update && apt install -y git python3.10-venv mariadb-server pkg-config libmysqlclient-dev gcc g++ make libxml2-dev libxslt1-dev zlib1g-dev gettext curl redis-server  supervisor nginx memcached libmemcached-tools

RUN mkdir -p /projects/dmoj
RUN mkdir -p /projects/dmoj/tmp
RUN mkdir -p /projects/dmoj/cache
RUN mkdir -p /projects/dmoj/static
RUN mkdir -p /projects/dmoj/https

WORKDIR /projects/dmoj

RUN python3 -m venv venv && \
    /projects/dmoj/venv/bin/pip3 install websocket-client && \
    /projects/dmoj/venv/bin/pip3 install Redis && \
    /projects/dmoj/venv/bin/pip3 install uwsgi && \
    /projects/dmoj/venv/bin/pip3 install pymemcache

RUN python3 -m venv venv && \
    git clone https://github.com/DAN3002/dmoj.git && \
    mv dmoj site && \
    cd site && \
    git switch change-to-env && \
    git submodule init && \
    git submodule update && \
    /projects/dmoj/venv/bin/pip3 install -r requirements.txt && \ 
    /projects/dmoj/venv/bin/pip3 install mysqlclient

# Uncomment if use mailgun
# RUN /projects/dmoj/venv/bin/pip3 install django-mailgun

# Uncomment if use sendgrid
# RUN /projects/dmoj/venv/bin/pip3 install sendgrid-django

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

RUN npm install -g sass postcss-cli postcss autoprefixer

RUN cd /projects/dmoj/site && npm install qu ws simplesets

COPY dmoj.nginx /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/dmoj.nginx /etc/nginx/sites-enabled

COPY bridged.conf /etc/supervisor/conf.d/
COPY celery.conf /etc/supervisor/conf.d/
COPY wsevent.conf /etc/supervisor/conf.d/
COPY site.conf /etc/supervisor/conf.d/
COPY start-dmoj.sh /projects/dmoj/
COPY https /projects/dmoj/https
COPY uwsgi.ini /projects/dmoj/site
# COPY local_settings.py /projects/dmoj/site/dmoj

RUN chmod +x /projects/dmoj/start-dmoj.sh

EXPOSE 80 443 9999 9998 15100 15101 15102

CMD ["/projects/dmoj/start-dmoj.sh"]



