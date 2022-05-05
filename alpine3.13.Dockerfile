ARG PHP_VER

FROM php:${PHP_VER}-fpm-alpine3.13

RUN apk add --no-cache nginx=1.18.0-r15 \
                       postgresql=13.6-r0 \
                       postgresql-dev=13.6-r0 \
                       autoconf=2.69-r3 \
                       g++=10.2.1_pre1-r3 \
                       make=4.3-r0 \
    && docker-php-ext-configure pgsql \
    && docker-php-ext-install pdo pdo_mysql opcache pdo_pgsql pgsql \
    && pecl install redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && rm -rf /tmp/pear \
    && mkdir -p /code \
    && mkdir -p /alloc/logs \
    && mkdir -p /run/nginx \
    && chmod -R 777 /alloc/logs \
    && sed -i \
           -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" \
           -e "s/pm.max_children = 5/pm.max_children = 4/g" \
           -e "s/pm.start_servers = 2/pm.start_servers = 3/g" \
           -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" \
           -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" \
           -e "s/;pm.max_requests = 500/pm.max_requests = 200/g" \
           -e "s/user = www-data/user = nginx/g" \
           -e "s/group = www-data/group = nginx/g" \
           -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" \
           -e "s/;listen.mode = 0660/listen.mode = 0666/g" \
           -e "s/;listen.owner = www-data/listen.owner = nginx/g" \
           -e "s/;listen.group = www-data/listen.group = nginx/g" \
           -e "s/;listen.backlog = 511/listen.backlog = 8192/g" \
           -e "s/^;clear_env = no$/clear_env = no/" \
           /usr/local/etc/php-fpm.d/www.conf

COPY nginx.conf /etc/nginx/
COPY php.ini /usr/local/etc/php/
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE 80
EXPOSE 443

WORKDIR /code

ENTRYPOINT ["/entrypoint.sh"]
