FROM ubuntu:latest
RUN apt-get update && apt-get -y install bash net-tools iputils-ping
EXPOSE 80
EXPOSE 8000