FROM ubuntu:20.04

RUN apt update && apt install -y openssh-server
RUN mkdir -p /run/sshd

COPY entrypoint.sh /entrypoint.sh
CMD /entrypoint.sh
