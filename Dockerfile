FROM ubuntu:22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

RUN apt-get update && \
    apt-get install -y apt-utils tzdata openssh-server python3.11 python3-pip ansible curl && \
    mkdir -p /var/run/sshd && \
    useradd -m -s /bin/bash ansibleuser && \
    echo "ansibleuser:ansibleuser" | chpasswd && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
