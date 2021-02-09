FROM debian:buster

RUN apt-get update
RUN apt-get -y install nginx

COPY srcs/start.sh .

CMD bash ./start.sh

EXPOSE 80
EXPOSE 443
