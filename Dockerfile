FROM cine/base-image-docker

MAINTAINER Thomas Shafer <thomas@cine.io>

# get sources for nginx, ffmpeg and nginx-rtmp-module
WORKDIR /usr/src
RUN git clone git@github.com:nginx/nginx.git

WORKDIR /usr/src/nginx
RUN git checkout v1.6.2
RUN ./configure \
  --with-debug \
  --prefix=/usr/local \
  --conf-path=/usr/local/etc/nginx.conf \
  --error-log-path=/dev/stderr \
  --http-log-path=/dev/stdout \
  --pid-path=/var/run/nginx.pid \
  --http-client-body-temp-path=/tmp/nginx/client_body_temp \
  --http-proxy-temp-path=/tmp/nginx/proxy_temp \
  --http-fastcgi-temp-path=/tmp/nginx/fastcgi_temp \
  --http-uwsgi-temp-path=/tmp/nginx/uwsgi_temp \
  --http-scgi-temp-path=/tmp/nginx/scgi_temp \
  --with-http_ssl_module

RUN make install
RUN make clean

# make a tmp directory for some nginx intermediate files
RUN mkdir /tmp/nginx

# make sure the ffmpeg transcoding log file exists
RUN touch /var/log/access.log

# copy our service
COPY service /service

# start nginx
CMD ["/service/bin/run"]

# configuration
EXPOSE 80
EXPOSE 443

# CERTS: /etc/nginx/certs
