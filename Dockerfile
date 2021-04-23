FROM openjdk:8-jdk-alpine

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

RUN apt-get install -y tzdata
RUN addgroup -g 1000 bd
RUN adduser -u 1000 -G bd -D bd

RUN mkdir -p /auth/run
RUN mkdir -p /auth/logs
RUN mkdir -p /auth/lib
RUN mkdir -p /auth/conf
COPY src/main/resources/application.yml /auth/conf/application.yml
COPY target/auth-0.0.1-SNAPSHOT.jar /auth/lib/app.jar
RUN chown -R bd:bd /auth
USER bd

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","-Dspring.config.location=/auth/conf/application.yml","/auth/lib/app.jar"]

