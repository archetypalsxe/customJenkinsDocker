FROM debian:stable

USER root

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
      gnupg \
      wget \
      lsb-release \
      vim \
      openjdk-8-jdk \
      apt-transport-https && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
    wget https://download.docker.com/linux/debian/gpg && apt-key add gpg && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee -a /etc/apt/sources.list.d/docker.list && \
    wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | apt-key add && \
    echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
      apache2 \
      libapache2-mod-php7.1 \
      php7.1 \
      php7.1-mysql \
      php7.1-gd \
      php7.1-xml \
      php7.1-curl \
      docker-ce \
      jenkins && \
    apt-get clean && rm -r /var/lib/apt/lists/*

RUN a2dismod mpm_event && \
    a2enmod mpm_prefork \
            ssl \
            headers \
            ssl \
            rewrite && \
    a2ensite default-ssl && \
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2
#ENV APACHE_LOCK_DIR /var/lock/apache2
#ENV APACHE_PID_FILE /var/run/apache2.pid
#
#WORKDIR /var/www/sites

EXPOSE 443
EXPOSE 80
EXPOSE 8080

COPY ./dockerStart.sh /usr/bin/
RUN chmod -f 777 /usr/bin/dockerStart.sh

CMD ["/usr/bin/dockerStart.sh", "-D", "FOREGROUND"]
