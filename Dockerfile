FROM php:fpm

LABEL maintainer='Rex Zeng, rex@rexskz.info'

ENV MYNUAA_ROOT_PATH /www

# add sourcelist
#RUN echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main' > /etc/apt/sources.list
#RUN echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main' >> /etc/apt/sources.list

# install some extensions
RUN apt-get update
RUN apt-get install -y libicu-dev libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev libmemcached-dev zlib1g-dev libsasl2-dev
RUN docker-php-ext-install mysqli pdo_mysql

# for gd
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# for memcached
RUN yes '' | pecl install igbinary memcached
RUN docker-php-ext-enable igbinary.so memcached.so

# clear cache
RUN apt-get clean && pecl clear-cache

EXPOSE 9000
