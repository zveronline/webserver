FROM php:7.2-fpm-alpine
RUN apk add --update --no-cache tzdata freetype libpng libjpeg-turbo icu libmcrypt icu-data-full diffutils zip libzip imagemagick gmp \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && echo "Europe/Moscow" > /etc/timezone \
    && apk del tzdata
RUN apk add --update --no-cache --virtual .build-deps freetype-dev libpng-dev libjpeg-turbo-dev g++ make autoconf zlib-dev icu-dev libmcrypt-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-configure gd \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j$(nproc) gd \ 
    && docker-php-ext-configure intl && docker-php-ext-install intl \
    && pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt \
    && pecl clear-cache \
    && apk del -f .build-deps \
    && rm -rf /tmp/*
ADD conf/uploads.ini /usr/local/etc/php/conf.d/uploads.ini