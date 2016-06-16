FROM ubuntu:trusty
MAINTAINER Xiekers <im@xieke.org>

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

#Replace Sources.list To Ustc mirrors
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
ADD sources.list /etc/apt/sources.list

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive && apt-get -y install openssh-server pwgen vim git
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

#Define SoftWare
RUN apt-get install curl unzip python-pip python3-pip -y

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**

EXPOSE 22 80
CMD ["/run.sh"]
