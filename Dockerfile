FROM openjdk:8-jdk-alpine

ARG TIMEZONE="Asia/Seoul"

RUN apk add tzdata
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
RUN echo "Asia/Seoul" > /etc/timezone
ENV LANG=ko_KR.UTF-8

RUN addgroup -g 1000 bd
RUN adduser -u 1000 -G bd -D bd

RUN mkdir -p /data/auth/run
RUN mkdir -p /data/auth/logs
RUN mkdir -p /data/auth/lib
RUN mkdir -p /data/auth/conf
COPY src/main/resources/application.yml /data/auth/conf/application.yml
COPY target/auth-0.0.1-SNAPSHOT.jar /data/auth/lib/app.jar
RUN chown -R bd:bd /data
USER bd

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","-Dspring.config.location=/data/auth/conf/application.yml","-Duser.timezone=Asia/Seoul","/data/auth/lib/app.jar"]
