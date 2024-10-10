FROM php:8.3-fpm-alpine
RUN apk add --update --no-cache tzdata freetype libpng libjpeg-turbo libmemcached zlib \
&& cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
&& echo "Europe/Moscow" > /etc/timezone \
&& apk del tzdata
RUN apk add --update --no-cache --virtual .build-deps freetype-dev libpng-dev libjpeg-turbo-dev libmemcached-dev g++ make autoconf zlib-dev
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache \
&& docker-php-ext-configure gd \
--with-freetype \
--with-jpeg \
NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
&& docker-php-ext-install -j$(nproc) gd \ 
&& pecl install memcached-3.2.0 \
&& docker-php-ext-enable memcached \
&& apk del -f .build-deps \
&& rm -rf /tmp/*