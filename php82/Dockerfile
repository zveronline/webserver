FROM php:8.2-fpm-alpine
RUN apk add --update --no-cache tzdata freetype libpng libjpeg-turbo libmemcached icu icu-data-full diffutils zip libzip imagemagick \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && echo "Europe/Moscow" > /etc/timezone \
    && apk del tzdata
RUN apk add --update --no-cache --virtual .build-deps freetype-dev libpng-dev libjpeg-turbo-dev libmemcached-dev g++ make autoconf zlib-dev icu-dev pcre-dev libzip-dev imagemagick-dev gmp-dev \
    && pecl install memcached-3.2.0 redis apcu imagick \
    && docker-php-ext-configure gd zip \
#    --with-zlib-dir=/usr \
    --with-freetype \
    --with-jpeg \
    && docker-php-ext-configure intl \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j$(nproc) gd exif zip mysqli pdo pdo_mysql opcache intl gmp \ 
    && docker-php-ext-enable memcached redis apcu exif intl zip mysqli pdo pdo_mysql opcache imagick \
    && pecl clear-cache \
    && apk del -f .build-deps \
    && rm -rf /tmp/*
ADD modules/opcache.ini /usr/local/etc/php/conf.d/opcache.ini