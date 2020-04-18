FROM php:7.4.5-fpm

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

USER 1000:www-data

WORKDIR /usr/share/nginx/html

