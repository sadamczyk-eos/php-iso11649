FROM php:5.6-cli-alpine

COPY --from=composer/composer:lts-bin /composer /usr/bin/composer

RUN docker-php-ext-install bcmath

WORKDIR /php-iso11649
COPY ["composer.json", "composer.lock", "./"]
RUN composer install --no-interaction

COPY ./phpunit.xml ./
COPY ./tests tests/
COPY ./src src/

CMD ["php", "vendor/bin/phpunit"]
