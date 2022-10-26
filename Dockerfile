ARG PHP_EXTENSIONS="pdo_mysql pdo_sqlite bcmath gd"
FROM thecodingmachine/php:8.1-v4-slim-apache AS php
ENV TEMPLATE_PHP_INI=production \
    APACHE_DOCUMENT_ROOT=/var/www/html/public

ENV COMPOSER_ALLOW_SUPERUSER 1

ADD --chown=docker:docker . /var/www/html

WORKDIR /var/www/html

### PHP Development
FROM php AS php-dev

ARG GITHUB_PERSONAL_TOKEN
RUN COMPOSER_AUTH="{\"github-oauth\": {\"github.com\": \"$GITHUB_PERSONAL_TOKEN\"}}" composer install

### PHP Production
FROM php AS php-prod

ARG GITHUB_PERSONAL_TOKEN
RUN COMPOSER_AUTH="{\"github-oauth\": {\"github.com\": \"$GITHUB_PERSONAL_TOKEN\"}}" composer install --quiet --optimize-autoloader

WORKDIR /var/www/html


FROM mysql:8.0 AS db
RUN echo "USE mysql;" > /docker-entrypoint-initdb.d/timezones.sql &&  mysql_tzinfo_to_sql /usr/share/zoneinfo >> /docker-entrypoint-initdb.d/timezones.sql
