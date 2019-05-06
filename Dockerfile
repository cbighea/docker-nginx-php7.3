FROM php:7.3-fpm-stretch

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -qq \
    cron \
    gnupg \
    libxml2-dev \
    libzip-dev \
    lsb-release \
    procps \
    supervisor \
    vim \
    unzip \
    zlib1g-dev

# Install the latest stable version of nginx
RUN curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -
RUN echo "deb http://nginx.org/packages/debian `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list
RUN DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -qq nginx

# Set up composer for PHP libraries
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP Extensions
RUN docker-php-ext-install opcache pdo_mysql zip && pecl install redis && docker-php-ext-enable redis
