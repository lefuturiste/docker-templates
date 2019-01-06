# Docker template

## Php fpm + nginx

image: `lefuturiste/php-fpm`

- php version 7.2
- debian + nginx + php-fpm + php
- composer support
- auto run of composer init script in your app

## Php cli only

image: `lefuturiste/php`

- useful for worker for instance
- php version 7.2
- debian + php-cli

## Vue single page app

image: `lefuturiste/vue-spa`

- node + nginx
- expose on 80
