FROM ubuntu:22.04

RUN apt update && \
    apt install -y openssh-server python3.11 python3-pip ansible && \
    mkdir -p /var/run/sshd && \
    useradd -m -s /bin/bash ansibleuser && \
    echo "ansibleuser:ansibleuser" | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
