FROM php:7.2-apache

RUN echo '"\\e[5~": history-search-backward' >> /etc/inputrc \
 && echo '"\\e[6~": history-search-forward' >> /etc/inputrc

RUN apt-get update \
 && apt-get dist-upgrade --yes --auto-remove \
 && apt-get --yes install certbot \
                          cron \
                          git \
                          libpng-dev \
                          libfreetype6-dev \
                          libcurl4-gnutls-dev \
                          libicu-dev \
                          libjpeg62-turbo-dev \
                          libmcrypt-dev \
                          libxslt-dev \
                          python-certbot-apache \
                          vim \
                          unzip
RUN sed -i -e 's/"syntax on/syntax on/' /etc/vim/vimrc \
 && sed -i -e 's/exec/\/usr\/sbin\/cron\n\nexec/' /usr/local/bin/docker-php-entrypoint
RUN docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-freetype-dir=/usr/include/freetype2 \
        --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install bcmath curl gd hash iconv intl json mbstring opcache pdo_mysql simplexml soap xml xsl zip
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN curl -O https://phar.phpunit.de/phpunit.phar \
 && mv phpunit.phar /usr/local/bin/phpunit \
 && chmod +x /usr/local/bin/phpunit
RUN curl -s http://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer
RUN a2enmod rewrite
RUN a2enmod ssl

VOLUME /etc/letsencrypt
VOLUME /etc/apache2/sites-available
VOLUME /etc/apache2/sites-enabled
VOLUME /var/www/magento2

WORKDIR /var/www/magento2