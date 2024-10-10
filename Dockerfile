FROM php:8.3-fpm-alpine
RUN apk add --update --no-cache tzdata freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libmemcached-dev g++ make autoconf \
&& cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
&& echo "Europe/Moscow" > /etc/timezone \
&& apk del tzdata \
&& docker-php-ext-install mysqli pdo pdo_mysql opcache
RUN docker-php-ext-configure gd \
--with-freetype \
--with-jpeg \
NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
docker-php-ext-install -j$(nproc) gd \ 
&& apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev \
&& pecl install memcached-3.2.0 \
&& docker-php-ext-enable memcached \
&& rm -rf /tmp/*