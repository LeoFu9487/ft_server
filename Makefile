imagename = yfu
containername = yfuyfu

all : im run

im :
	@sudo docker build -t $(imagename) .

run :
	@sudo docker run -d -p 80:80 -p 443:443 --name=$(containername) $(imagename)

off :
	@sudo docker run --env AUTOINDEX=off --name $(containername) -d -p 443:443 -p 80:80 $(imagename)

ip :
	@sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(containername)

stay :
	@sudo docker run  -it $(imagename) sh

containers := $(shell sudo docker ps -a -q)
images := $(shell sudo docker images -a -q)

showc :
	@sudo docker ps -a

showi :
	@sudo docker images

clean :
	@sudo docker rm -f $(containers)

fclean :	clean
	@sudo docker rmi -f $(images)

re : fclean all
