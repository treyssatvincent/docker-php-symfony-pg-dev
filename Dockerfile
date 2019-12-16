FROM php:7.4-fpm

RUN apt-get update && apt-get install -y libicu-dev \
		libpq-dev 

RUN pecl install apcu

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
		&& docker-php-ext-install intl \
		# pdo \
		pgsql \
		opcache \
		&& docker-php-ext-enable apcu

WORKDIR /usr/share/nginx/html

