FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basics + SSH + sudo
RUN apt update && apt install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    nano \
    net-tools \
    iputils-ping \
    && mkdir /var/run/sshd

# Set root password
RUN echo 'root:sam123' | chpasswd

# Allow root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
