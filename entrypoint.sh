#!/bin/sh

set -ex

SERVERS=""
WORKER="${N_WORKER:-1}"

for ID in $(seq 1 ${WORKER}); do
    cp /usr/local/etc/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www${ID}.conf
    sed -e "s|php-fpm.sock|php-fpm${ID}.sock|" -i /usr/local/etc/php-fpm.d/www${ID}.conf
    /usr/local/sbin/php-fpm --force-stderr --nodaemonize --fpm-config /usr/local/etc/php-fpm.d/www${ID}.conf &
    SERVERS="${SERVERS}server unix:/var/run/php-fpm${ID}.sock;"
done;

sed -e "s|{{SERVERS}}|${SERVERS}|" -i /etc/nginx/nginx.conf

nginx
