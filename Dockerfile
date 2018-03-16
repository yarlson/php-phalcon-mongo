FROM php:7.2.3-fpm-alpine3.7

MAINTAINER Yar Kravtsov <yarlson@gmail.com>

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add --no-cache php7-mongodb && \
    apk add --no-cache alpine-sdk bash autoconf && \
    mkdir -p /usr/local/src/cphalcon && \
    git clone -b 3.3.x --single-branch --depth=1 git://github.com/phalcon/cphalcon.git /usr/local/src/cphalcon && \
    cd /usr/local/src/cphalcon/build &&\
    ./install && \
    docker-php-ext-enable phalcon && \
    rm -Rf /usr/local/src/cphalcon/ && \
    apk del alpine-sdk && \
    apk add --no-cache $PHPIZE_DEPS && \
    pecl install xdebug-2.6.0beta1 && \
    docker-php-ext-enable xdebug && \
    apk del $PHPIZE_DEPS

