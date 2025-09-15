FROM php:8.3-fpm-alpine
RUN apk add --update --no-cache tzdata freetype libpng libjpeg-turbo libmemcached icu icu-data-full diffutils zip libzip imagemagick gmp \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && echo "Europe/Moscow" > /etc/timezone \
    && apk del tzdata
RUN apk add --update --no-cache --virtual .build-deps freetype-dev libpng-dev libjpeg-turbo-dev libmemcached-dev g++ make autoconf zlib-dev icu-dev pcre-dev libzip-dev imagemagick-dev gmp-dev \
    && pecl install memcached-3.2.0 redis apcu imagick \
    && docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    && docker-php-ext-configure intl \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j$(nproc) zip gd exif mysqli pdo pdo_mysql opcache intl gmp \
    && docker-php-ext-enable memcached redis apcu exif intl zip mysqli pdo pdo_mysql opcache imagick gmp \
    && pecl clear-cache \
    && apk del -f .build-deps \
    && rm -rf /tmp/*
ADD modules/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
ADD conf/uploads.ini /usr/local/etc/php/conf.d/uploads.ini