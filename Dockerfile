FROM php:7.1.8-fpm

RUN docker-php-ext-install mysqli pdo_mysql
