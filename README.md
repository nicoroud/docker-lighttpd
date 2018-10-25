# docker-lighttpd
Fast and light httpd server runing in docker

Just run :
~~~
docker run -d -v ~:/var/www/ -p 8080:80 lighthttpd
~~~
And point your webrowser to `http://LIGHTTPD_IP:8080`

Or you can use a docker-compose.yml file to use with nginx web proxy and let'sencrypt :
~~~
version: '3'

services:
  httpd:
    container_name: lighttpd
    image: nicoroud/docker-lighttpd
    restart: always
    networks:
      - default
    expose:
      - "80"
    environment:
      - TZ=Europe/Paris
      - VIRTUAL_HOST=domain.com
      - VIRTUAL_PORT=80
      - LETSENCRYPT_HOST=domain.com
      - LETSENCRYPT_EMAIL=your@email.com
    volumes:
      - /var/www/html:/var/www
      - ./lighttpd:/etc/lighttpd
networks:
  default:
    external:
      name: webproxy
~~~
