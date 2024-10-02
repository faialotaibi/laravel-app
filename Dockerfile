FROM php:8

WORKDIR /app

RUN apt update -yy && apt install zip unzip -yy \
    && curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

COPY composer* .
RUN composer install --no-dev --no-autoloader --no-scripts

COPY . .

RUN cp .env.example .env
RUN composer dump-autoload

RUN php artisan key:generate

CMD ["php", "artisan", "serve", "--host=0.0.0.0"]

