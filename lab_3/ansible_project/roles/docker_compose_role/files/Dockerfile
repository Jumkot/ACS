FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server sudo python3 python3-pip && \
    echo 'root:password' | chpasswd && \
    service ssh start

RUN mkdir -p /var/run/sshd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
