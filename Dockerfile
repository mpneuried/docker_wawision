FROM ubuntu:17.10
LABEL maintainer="https://github.com/mpneuried"

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y apt-utils 
RUN apt-get install -y curl
RUN apt-get install -y wget

# install apache
RUN apt-get install -y apache2
# configure apache
RUN echo "ServerName 0.0.0.0" >> /etc/apache2/apache2.conf
RUN apache2ctl configtest
RUN a2enmod rewrite

# install php
RUN apt-get install -y php
RUN apt-get install -y libapache2-mod-php php-mcrypt php-mysql
RUN apt-get install -y php-cli

ENV TERM=xterm

# install wawision deps
RUN apt-get install -y php-mysql
RUN apt-get install -y php-soap
RUN apt-get install -y php-imap
RUN apt-get install -y php-fpm
RUN phpenmod imap
RUN apt-get install -y php-zip
RUN apt-get install -y php-gd
RUN apt-get install -y php-xml
RUN apt-get install -y php-curl
RUN apt-get install -y php-mbstring

# install ioncube
RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
RUN tar xfz ioncube_loaders_lin_x86-64.tar.gz
RUN cp ioncube/ioncube_loader_lin_7.1.so $(php -i | grep extension_dir | awk '{print $3}')

RUN echo "zend_extension = \"$(php -i | grep extension_dir | awk '{print $3}')/ioncube_loader_lin_7.1.so\"" > /etc/php/7.1/apache2/conf.d/00-ioncube.ini
RUN chmod 777 /etc/php/7.1/apache2/conf.d/00-ioncube.ini

# install wawision
COPY 17.3_oss_wawision.tar.gz /var/www/html/package.tar.gz

WORKDIR /var/www/html/
RUN tar xzf package.tar.gz
RUN rm index.html
RUN rm package.tar.gz

RUN mv /var/www/html/17.3_oss_wawision/* /var/www/html/
RUN rm -rf /var/www/html/17.3_oss_wawision/

# redefine user
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

WORKDIR /var/www/html/wawision/

EXPOSE 80

CMD ["apachectl", "-e", "info", "-D", "FOREGROUND"]