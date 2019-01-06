#!/bin/bash

echo "> start script started"

# env vars
if [[ -e /env_vars_added.check ]]
then
    rm /etc/php/7.2/fpm/pool.d/www.conf
    cp /etc/php/7.2/fpm/pool.d/www.conf.opsave /etc/php/7.2/fpm/pool.d/www.conf
else
    # first time
    echo "> copy ..."
    cp /etc/php/7.2/fpm/pool.d/www.conf /etc/php/7.2/fpm/pool.d/www.conf.opsave
    touch /env_vars_added.check
fi
echo "> adding env vars..."
php /add_env_vars.php
echo "> done"

echo "> running composer install..."
composer install
echo "> done"

echo "> running composer init_app..."
composer run init_app
echo "> done"

echo "> starting php7.2-fpm..."
service php7.2-fpm start
echo "> done"

echo "> starting nginx server..."
nginx -g "daemon off;"
echo "> end of nginx server"
