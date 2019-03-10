FROM php:7.3.3-apache-stretch
COPY --chown=www-data mrbs-1.7.3/web/  /var/www/html/
COPY --chown=www-data auth_linuxmuster62.inc  /var/www/html/auth/
COPY mrbs-1.7.3/tables.my.sql /usr/share/linuxmuster-mrbs/tables.my.sql
COPY locale.gen /etc/locale.gen
COPY ldap.conf /etc/ldap/ldap.conf
COPY linuxmuster-mrbs-entrypoint /usr/local/bin/linuxmuster-mrbs-entrypoint
RUN apt-get update
RUN apt-get install -y mysql-client locales libldap2-dev  
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu
RUN docker-php-ext-install ldap
RUN docker-php-ext-install pdo pdo_mysql
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*
COPY php.ini-production /usr/local/etc/php/php.ini
ENTRYPOINT /usr/local/bin/linuxmuster-mrbs-entrypoint
 
