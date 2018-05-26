FROM openjdk:8u111-jdk-alpine

ENV author="Gearoid Gman Maguire"

VOLUME /tmp

ADD /target/gs-rest-service-0.1.0.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]