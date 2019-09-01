Magento 2 Multisite
===================

Magento 2 docker services platform for multiple sites.

Features
--------

- For Magento 2.3 version.
- Composer.
- PHP 7.2.
- xdebug.
- phpunit.
- Apache 2.

Download proyect
----------------

~~~~
git clone git@github.com:jpcandioti/magento2-multisite.git
~~~~

Define config files
-------------------

### Docker Compose file

~~~~
cp docker-compose.yml.dist docker-compose.yml
~~~~


### PHP config file

~~~~
cp php/php.ini.dist php/php.ini
~~~~



Docker image
-----------

### Download docker image from Docker Hub repository

~~~~
docker-compose pull
~~~~

### Or, build docker image

~~~~
docker build -t jpcandioti/magento2-multisite:latest .
~~~~


Install a site
--------------

### Add config vhost file

~~~~
cp httpd/sites-available/example.develop.conf httpd/sites-enabled/myshop.com.conf
~~~~

### Edit config vhost file

~~~~
vim httpd/sites-enabled/myshop.com.conf
~~~~

### Install magento site files

~~~~
mv /home/user/myshop.com ./sites/
~~~~


Install letsencrypt
-------------------

In Certbot site, go to Apache on Debian 10 (buster): https://certbot.eff.org/lets-encrypt/debianbuster-apache

Manager Docker Containers
-------------------------

### Create and start docker containers

~~~~
docker-compose up -d
~~~~

### Stop docker containers

~~~~
docker-compose stop
~~~~

### Resume docker containers

~~~~
docker-compose start
~~~~
