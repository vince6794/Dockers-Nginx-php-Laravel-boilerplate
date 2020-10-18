FROM php:7.2-fpm-alpine

#ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html
RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html

#Install mysql plugin
RUN docker-php-ext-install pdo pdo_mysql

#Install xdebug extension
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

USER laravel
#CMD ["php-fpm"]