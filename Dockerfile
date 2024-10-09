FROM php:8.3-fpm-alpine
RUN apk add --update --no-cache tzdata zlib \
&& cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
&& echo "Europe/Moscow" > /etc/timezone \
&& apk del tzdata
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache gd