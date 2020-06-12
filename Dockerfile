FROM php:7.4.7-fpm

RUN apt-get update && apt-get install -y libicu-dev \
		libpq-dev \
		&& apt-get autoremove -y \
		&& rm -rf /var/lib/apt/lists/*

RUN pecl install apcu

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
		&& docker-php-ext-install intl \
		pdo_pgsql \
		pgsql \
		opcache \
		&& docker-php-ext-enable apcu

# phpunit
RUN curl -L -o /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar
RUN chmod +x /usr/local/bin/phpunit

# xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN echo "zend_extension=\"/usr/local/lib/php/extensions/no-debug-non-zts-20190902/xdebug.so\"" >> /usr/local/etc/php/php.ini-development

# hack for macOS's users
USER 1000:www-data

WORKDIR /usr/share/nginx/html

