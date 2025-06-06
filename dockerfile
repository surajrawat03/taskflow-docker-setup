FROM php:7.4-apache

# Install PHP extensions and tools required by Laravel 8
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd opcache

# Enable Apache rewrite module (needed for Laravel routing)
RUN a2enmod rewrite

# Copy custom Apache configuration (if you have one)
COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Node.js (Option 1)
COPY --from=node:16 /usr/local/bin/ /usr/local/bin/
COPY --from=node:16 /usr/local/lib/ /usr/local/lib/
COPY --from=node:16 /usr/local/include/ /usr/local/include/
COPY --from=node:16 /usr/local/share/ /usr/local/share/


# Ensure npm is executable
# RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# Configure OPcache for performance
RUN echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.memory_consumption=128" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.interned_strings_buffer=8" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.max_accelerated_files=10000" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.revalidate_freq=0" >> /usr/local/etc/php/conf.d/opcache.ini

# Set working directory
WORKDIR /var/www/html