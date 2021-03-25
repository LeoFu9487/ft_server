FROM debian:buster

RUN apt-get update
RUN apt-get -y install nginx
RUN apt-get -y install wget
RUN apt-get install openssl

COPY srcs/default .

RUN rm -rf etc/nginx/sites-available/default
RUN cp default etc/nginx/sites-available/default

COPY srcs/start.sh .

CMD bash ./start.sh

EXPOSE 80
EXPOSE 443
