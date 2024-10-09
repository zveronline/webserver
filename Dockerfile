FROM php:8.3-fpm-alpine
RUN apk add --update --no-cache zlib \
&& cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
&& echo "Europe/Moscow" > /etc/timezone
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache gd