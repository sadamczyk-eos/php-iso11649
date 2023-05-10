# TODO:
# phpunit v4.8 only works with PHP 5.3 - 5.6, not 7. Does not seem to break here though? 8 does tho!
# Maybe update phpunit to ^5 at least? Since PHP version 5.6 is already required?
# In the end it's all unsupported anyway so....
# https://phpunit.de/supported-versions.html

FROM php:7-cli-alpine

COPY --from=composer/composer:lts-bin /composer /usr/bin/composer

RUN docker-php-ext-install bcmath

WORKDIR /php-iso11649
COPY ["composer.json", "composer.lock", "./"]
RUN composer update --no-interaction # TODO Use install instead of update!

COPY ./phpunit.xml ./
COPY ./tests tests/
COPY ./src src/

CMD ["php", "vendor/bin/phpunit"]
