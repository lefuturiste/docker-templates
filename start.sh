#!/bin/bash

echo "> start script started"

# env vars
if [[ -e /env_vars_added.check ]]
then
    rm /etc/php/7.4/fpm/pool.d/www.conf
    cp /etc/php/7.4/fpm/pool.d/www.conf.opsave /etc/php/7.4/fpm/pool.d/www.conf
else
    # first time
    echo "> copy ..."
    cp /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf.opsave
    touch /env_vars_added.check
fi

echo "> edit fpm/pool.d/www.conf ..."

echo "> adding env vars..."
php /add_env_vars.php
echo "> done"

echo "> pm config..."
php /config_fpm_pm.php
echo "> done"

echo "> nginx env vars config..."
php /config_nginx_env_vars.php
echo "> done"

echo "> crontab config..."
[ -f /app/tasks.cron ] && cp /app/tasks.cron /etc/cron.d/tasks && echo "Cron file tasks.cron copied in /etc/cron.d"
chmod 0644 /etc/cron.d/tasks
crontab /etc/cron.d/tasks
cron
echo "> done"

echo "> reloading cron..."
/etc/init.d/cron reload
echo "> done"

echo "> running composer install..."
composer install
echo "> done"

echo "> running composer init_app..."
composer run init_app
echo "> done"

echo "> starting php7.4-fpm..."
service php7.4-fpm start
echo "> done"

echo "> starting nginx server..."
nginx -g "daemon off;"
echo "> end of nginx server"
