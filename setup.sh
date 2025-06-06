#!/bin/bash

# Start Docker services
echo "Starting Docker containers..."
docker-compose up -d

# Install PHP dependencies
echo "Installing PHP dependencies..."
docker exec -it taskflow_app bash -c "if [ ! -d vendor ]; then composer install; fi"


# Fix permissions for storage and bootstrap/cache
echo "Setting correct permissions..."
docker exec -it taskflow_app bash -c "chown -R www-data:www-data storage bootstrap/cache && chmod -R 775 storage bootstrap/cache"


# Generate Laravel application key
echo "Generating Laravel application key..."
docker exec -it taskflow_app php artisan key:generate

# Run database migrations
# echo "Running database migrations..."
# docker exec -it taskflow_app php artisan migrate

echo "Setup complete!"
echo "Access Laravel at: http://localhost:8081"
echo "Access phpMyAdmin at: http://localhost:8082"