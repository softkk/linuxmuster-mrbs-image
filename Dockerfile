FROM php:7.3.3-apache-stretch
COPY --chown=www-data mrbs-1.7.3/web/  /var/www/html/
COPY mrbs-1.7.3/tables.my.sql /usr/share/linuxmuster-mrbs/tables.my.sql
COPY locale.gen /etc/locale.gen
COPY linuxmuster-mrbs-entrypoint /usr/local/bin/linuxmuster-mrbs-entrypoint
RUN apt-get update
RUN apt-get install -y mysql-client locales
RUN apt-get clean -y
RUN docker-php-ext-install pdo pdo_mysql 
ENTRYPOINT /usr/local/bin/linuxmuster-mrbs-entrypoint
 
