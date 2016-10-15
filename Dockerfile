# # # # # # # # # # # # # # # # # # # # #
#
# Ubuntu Trusty (14.04)
# LAMP Environment (Apache2, Mysql, Php)
#
# # # # # # # # # # # # # # # # # # # # #
FROM ubuntu:14.04
MAINTAINER Amine D. <amine.dai@free.fr>
ENV DEBIAN_FRONTEND noninteractive

# non-root unix user name
ENV username dev

# MySQL root password
ENV tmp_pass root

# Name of the start servers script
ENV start_script start_servers


# Install required libs:
RUN apt-get update
RUN apt-get -y install build-essential libpcre3 libpcre3-dev libssl-dev git wget vim

# Install LAMP:
RUN apt-get -y install apache2 php5
RUN echo '${tmp_pass} ${tmp_pass}' | apt-get -y install mysql-server

# Install PHP Libs:
RUN apt-get -y install php5-mcrypt php5-mysql php5-gd php5-curl php5-memcached
RUN apt-get -y install php-soap php5-fpm php-gettext php5-intl sqlite3

# Create user:
RUN adduser --disabled-password --gecos "" ${username}
RUN adduser ${username} sudo
RUN su ${username}
WORKDIR /home/${username}
RUN mkdir www
RUN ln -s /home/${username}/www /var/www/html/${username}
RUN exit

# Install composer:
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# Goto /root
WORKDIR /root

# Start servers:
RUN touch ${start_script}
RUN chmod +x ${start_script}
RUN echo "#!/bin/bash" >> ${start_script}
RUN echo "/etc/init.d/apache2 start;" >> ${start_script}
RUN echo "/etc/init.d/mysql start;" >> ${start_script}
RUN echo "/etc/init.d/php5-fpm start;" >> ${start_script}

# # # # # # # # # # # # # # # # # # # #
#
# - Install phpmyadmin if necessary
#	$ apt-get install phpmyadmin
# - Add ssh private key
#	@todo write a doc
# - Clone a project or create one
# - Create virtual host for the project
#	@see how_to_create_a_vhost.md
#
# # # # # # # # # # # # # # # # # # # #
