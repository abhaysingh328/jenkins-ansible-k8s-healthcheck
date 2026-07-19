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
    net-tools \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Fix Ansible compatibility
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Create Ansible user
RUN useradd -m -s /bin/bash ansibleuser && \
    echo "ansibleuser:ansibleuser" | chpasswd && \
    usermod -aG sudo ansibleuser && \
    echo "ansibleuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansibleuser && \
    chmod 440 /etc/sudoers.d/ansibleuser

# Configure SSH
RUN mkdir /var/run/sshd && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config

# Expose SSH
EXPOSE 22

# Start SSH
CMD ["/usr/sbin/sshd","-D"]
