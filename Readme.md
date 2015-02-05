# nginx-ssl-docker

cine.io [Docker](https://docker.com/) container listens to http/websocket connections on 80 and 443 and can serve content from nginx.

# Notes

1. This only works for rtc-transmuxer right now.
* You'll have to add your own docker host to /etc/hosts
  * I recommend `192.168.59.103 docker-local.cine.io`
  * This is because the ssl cert only works for *.cine.io

# Usage

```bash
$ docker run -it --rm  -p 8080:80 -p 8081:443 --link "rtc-transmuxer:rtc-transmuxer" local/nginx-ssl-docker
```
