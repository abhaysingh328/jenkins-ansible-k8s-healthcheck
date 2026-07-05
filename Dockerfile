# Use stable Ubuntu base
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    python3-pip \
    python3-apt \
    iproute2 \
    net-tools && \
    rm -rf /var/lib/apt/lists/*

# Fix Ansible compatibility (VERY IMPORTANT)
RUN ln -s /usr/bin/python3 /usr/bin/python

# Create Ansible user
RUN useradd -m -s /bin/bash ansibleuser && \
    echo "ansibleuser:ansibleuser" | chpasswd && \
    adduser ansibleuser sudo

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
