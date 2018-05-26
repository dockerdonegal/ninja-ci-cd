|---------|
  PROJECT
|---------|

## create a project, maven java.
create a spring project "https://start.spring.io/" (Web, Actuator)
use this hello world example
https://spring.io/guides/gs/rest-service/

## build project using maven docker image
```
docker run -v "$PWD":/project -w /project maven:3.3.9-jdk-8 mvn clean package
```

## Run from terminal
```
java -jar target/actuator-sample-0.0.1-SNAPSHOT.jar
```
## Test the service
Now that the service is up, visit http://localhost:8080/greeting, where you see:
http://localhost:9080/greeting
```
{"id":1,"content":"Hello, World!"}
```

Provide a name query string parameter with http://localhost:8080/greeting?name=User. Notice how the value of the content attribute changes from "Hello, World!" to "Hello User!":
http://localhost:9080/greeting?name=docker donegal
```
{"id":2,"content":"Hello, User!"}
```

## build image
docker build -t dockerdonegal/helloworld:v1 .

## login to docker 
https://hub.docker.com/r/dockerdonegal/
```
docker login
Username: dockerdonegal
Password: {your-docker-hub-password}
```
## push image to 
docker push dockerdonegal/helloworld:v1

## pull our image and run it.
```
docker run -it -p 8080:8080 --name actuator dockerdonegal/helloworld:v2
```

|---------|
  TESTING
|---------|

## run 
docker run -v "$PWD":/project -w /project maven:3.3.9-jdk-8 mvn test


|---------|
  JENKINS
|---------|
pipelines
https://jenkins.io/doc/pipeline/tour/hello-world/

Add jenkinsfile to root of project

## Run Junkins Docker
docker-compose -f pipeline/docker-compose.yml up -d

DOCKER_PATH=$(which docker) docker-compose -f pipeline/docker-compose.yml up -d
> NOTE - Pipeline ERROR
```
[dockerdonegal] Running shell script
+ docker inspect -f . maven:3.3.3
/var/jenkins_home/workspace/dockerdonegal@tmp/durable-049bfc82/script.sh: line 1: docker: not found
[Pipeline] sh
[dockerdonegal] Running shell script
+ docker pull maven:3.3.3
/var/jenkins_home/workspace/dockerdonegal@tmp/durable-2ade8d04/script.sh: line 1: docker: not found
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
ERROR: script returned exit code 127
Finished: FAILURE
``` 

### First time running jenkins
https://jenkins.io/doc/tutorials/build-a-java-app-with-maven/
open browser at http://localhost:8090 , follow the on screen message "To ensure Jenkins is securely set up by the administrator, a password has been written to the log (not sure where to find it?) and this file on the server:"
run `docker logs jenkins` to get the password.
```
bac4b25f3e7d46fe81fd79e8efe8baea
```
press continue.
just install the suggested plugins, unless you know what plugins you only need.
should take a few minutes.
NEXT, create first admin user
```
username: docker
password: docker100%
Full name: docker
E-mail address: dockerdonegal@gmail.com
```
Save and finish button, start using Jenkins button.
well, done! Welcome to Jenkins!

## Create pipline


|----------------|
  DOCKER COMMANDS
|----------------|
```
# Clean Up
docker rm $(docker ps -a -f status=exited -q)

# build pipeline
docker-compose -f pipeline/docker-compose.yml build

# run pipeline, (jenkins)
docker-compose -f pipeline/docker-compose.yml up -d


```