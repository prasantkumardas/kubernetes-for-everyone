Clone a sample git repository using the below command or use your project for the demo:

git clone https://github.com/docker/getting-started-app.git
cd into the directory
cd getting-started-app/

Create an empty file with the name Dockerfile

touch Dockerfile

FROM node:18-alpine
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 3000

Build the docker image using the application code and Dockerfile

docker build -t day02-todo .

Verify the image has been created and stored locally using the below command:

docker images

Create a public repository on hub.docker.com and push the image to remote repo

docker login
docker tag day02-todo:latest username/new-reponame:tagname
docker images
docker push username/new-reponame:tagname

To pull the image to another environment , you can use below command

docker pull username/new-reponame:tagname

To start the docker container, use below command

docker run -dp 3000:3000 username/new-reponame:tagname

docker exec -it containername sh
or
docker exec -it containerid sh

To view docker logs
docker logs containername
or
docker logs containerid

Docker workflow:
![alt text](docker.png)


Multi-Stage Docker container

simple Java Hello World application:

root@kubemaster:~/docker# cat Helloworld.java
public class Helloworld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}

root@kubemaster:~/docker#

Multistage Docker file

root@kubemaster:~/docker# cat Dockerfile
FROM openjdk:11-jdk AS build
COPY Helloworld.java .
RUN javac Helloworld.java
#CMD ["java", "Helloworld"]

FROM openjdk:11-jre AS run
COPY --from=build Helloworld.class .
CMD ["java", "Helloworld"]
root@kubemaster:~/docker#

