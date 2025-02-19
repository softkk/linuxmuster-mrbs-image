FROM php:8.4.4-apache
COPY --chown=www-data mrbs-1.11.6/web/  /var/www/html/
COPY --chown=www-data mrbs-1.11.6/docker-config.inc.php /var/www/html/config.inc.php
COPY --chown=www-data auth_linuxmuster62.inc  /var/www/html/auth/
COPY --chown=www-data auth_linuxmuster7.inc  /var/www/html/auth/
COPY mrbs-1.11.6/tables.my.sql /usr/share/linuxmuster-mrbs/tables.my.sql
COPY locale.gen /etc/locale.gen
COPY ldap.conf /etc/ldap/ldap.conf
COPY linuxmuster-mrbs-entrypoint /usr/local/bin/linuxmuster-mrbs-entrypoint
RUN a2enmod rewrite
RUN apt-get update \
    && apt-get install -y default-mysql-client locales libldap2-dev libicu72 libicu-dev locales-all \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install ldap \
    && docker-php-ext-install mysqli pdo pdo_mysql intl \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
COPY php.ini-production /usr/local/etc/php/php.ini
ENTRYPOINT /usr/local/bin/linuxmuster-mrbs-entrypoint
