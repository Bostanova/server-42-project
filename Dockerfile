# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: eerika <eerika@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/23 22:53:30 by eerika            #+#    #+#              #
#    Updated: 2021/04/23 22:53:34 by eerika           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get install -y nginx \
php-mysql php-fpm php-cgi \
wget \
vim \
mariadb-server
RUN wget -O phpmyadmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
&& tar -xf phpmyadmin.tar.gz \
&& mv phpMyAdmin-5.0.4-all-languages /var/www/pma \
&& rm phpmyadmin.tar.gz
RUN wget -O wordpress.tar.gz https://ru.wordpress.org/latest-ru_RU.tar.gz \
&& tar -xf wordpress.tar.gz \
&& mv wordpress /var/www/wp \
&& rm wordpress.tar.gz 
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 \
-x509 \
-sha256 \
-days 365 \
-nodes \
-out /etc/nginx/ssl/private.pem \
-keyout /etc/nginx/ssl/public.key \
-subj "/C=RU/ST=AnyState/L=AnyCity/O=AnyOrganization/OU=AnyOrganizationUnit/CN=.ru"
COPY /srcs/nginx.conf /etc/nginx/sites-available/nginx.conf
COPY /srcs/wp-config.php /var/www/wp/
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf
RUN ln -s /var/www/wp /var/www/html/wp
RUN ln -s /var/www/pma /var/www/html/pma
RUN service mysql start \
&& echo "CREATE DATABASE wp;" | mysql -u root --skip-password \
&& echo "CREATE USER 'adm'@'localhost' IDENTIFIED BY 'adm';" | mysql -u root --skip-password \
&& echo "GRANT ALL PRIVILEGES ON *.* TO 'adm'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
RUN mkdir /var/www/pma/tmp
RUN chown -R www-data:www-data /var/www/ && chmod -R 755 /var/www/
EXPOSE 80 443
COPY /srcs/init.sh ./
CMD bash init.sh
