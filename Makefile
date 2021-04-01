imagename = yfu
containername = yfuyfu

all : im run

im :
	@sudo docker build -t $(imagename) .

run :
	@sudo docker run -d -p 80:80 --name=$(containername) $(imagename)

stay :
	@sudo docker run -it yfu sh

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
