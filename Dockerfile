FROM daocloud.io/centos:6
MAINTAINER Ice Dragon <517icedragon@gmail.com>

#install nginx/php-5.3/phpbrew/php-7.1 +default +mysql +pdo +fpm +curl +memcached
RUN yum install -y sudo-devel && \
    useradd land && \
    sed -i '$a land    ALL=(ALL)       NOPASSWD:ALL' /etc/sudoers

USER land

WORKDIR /home/land

RUN sudo yum install -y \
    gcc \
    wget \
    gcc+ \
    gcc-c++ \
    git && \
    sudo rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6 && \
    sudo rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
    sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-remi && \
    sudo curl --silent --location https://rpm.nodesource.com/setup_5.x | sudo bash - && \
    sudo yum -y install nodejs && \
    npm install -g polymer-cli && \
    npm install -g bower



# Expose nginx ssh
EXPOSE 80

# start-up nginx and fpm and ssh
CMD sudo mkdir -p /dockerdata/www/shop-1/shop && \
    cd /dockerdata/www/shop-1/shop/ && \
    polymer serve


