FROM php:8.3-fpm-alpine
RUN apk add --update --no-cache tzdata freetype libpng libjpeg-turbo libmemcached icu icu-data-full \
&& cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
&& echo "Europe/Moscow" > /etc/timezone \
&& apk del tzdata
RUN apk add --update --no-cache --virtual .build-deps freetype-dev libpng-dev libjpeg-turbo-dev libmemcached-dev g++ make autoconf zlib-dev icu-dev \
&& docker-php-ext-install mysqli pdo pdo_mysql opcache intl \
&& docker-php-ext-configure gd \
--with-freetype \
--with-jpeg \
NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
&& docker-php-ext-install -j$(nproc) gd \ 
&& pecl install memcached-3.2.0 \
&& docker-php-ext-enable memcached \
&& docker-php-ext-configure intl && docker-php-ext-install intl \
&& apk del -f .build-deps \
&& rm -rf /tmp/*