FROM php:7.2-fpm-alpine
RUN apk add --update --no-cache tzdata freetype libpng libjpeg-turbo icu libmcrypt diffutils zip libzip imagemagick gmp \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && echo "Europe/Moscow" > /etc/timezone \
    && apk del tzdata
RUN apk add --update --no-cache --virtual .build-deps freetype-dev libpng-dev libjpeg-turbo-dev g++ make autoconf zlib-dev icu-dev libmcrypt-dev pcre-dev libzip-dev imagemagick-dev gmp-dev \
    && pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt \
    && docker-php-ext-configure gd \
    && docker-php-ext-configure intl \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql intl \ 
    && pecl clear-cache \
    && apk del -f .build-deps \
    && rm -rf /tmp/*
ADD conf/uploads.ini /usr/local/etc/php/conf.d/uploads.ini