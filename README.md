# TaskFlow Docker Setup

A complete Docker setup for the TaskFlow Laravel application with Apache, MySQL, and phpMyAdmin.

## 📋 Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Docker Desktop** - [Download here](https://www.docker.com/products/docker-desktop/)
- **Git** - [Download here](https://git-scm.com/downloads)
- **Git Bash** (for Windows users) - Comes with Git installation

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone <your-repository-url>
cd taskflow-docker-setup
```

### 2. Environment Setup
Create a `.env` file in the project root with the following variables:
```env
# MySQL Configuration
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=taskflow_db
MYSQL_USER=taskflow_user
MYSQL_PASSWORD=your_password

# Laravel Configuration (will be generated)
APP_NAME=TaskFlow
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8081

# Database Configuration
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=taskflow_db
DB_USERNAME=taskflow_user
DB_PASSWORD=your_password

# JWT Configuration (will be generated)
JWT_SECRET=
JWT_TTL=60
JWT_REFRESH_TTL=20160
```

### 3. Run the Setup Script
```bash
# For Windows users (Git Bash)
./setup.sh

# For Linux/Mac users
chmod +x setup.sh
./setup.sh
```

### 4. Access Your Application
- **Laravel Application**: http://localhost:8081
- **phpMyAdmin**: http://localhost:8082
  - Username: `root`
  - Password: (your MYSQL_ROOT_PASSWORD)

## 🔧 Manual Setup (Alternative)

If the setup script doesn't work, you can run the commands manually:

### 1. Start Docker Containers
```bash
docker-compose up -d
```

### 2. Install PHP Dependencies
```bash
docker exec -it taskflow_app bash -c "if [ ! -d vendor ]; then composer install; fi"
```

### 3. Fix Permissions
```bash
docker exec -it taskflow_app bash -c "chown -R www-data:www-data storage bootstrap/cache && chmod -R 775 storage bootstrap/cache"
```

### 4. Generate Laravel Application Key
```bash
docker exec -it taskflow_app php artisan key:generate
```

### 5. Generate JWT Secret (if using JWT authentication)
```bash
docker exec -it taskflow_app php artisan jwt:secret
```

### 6. Run Database Migrations (optional)
```bash
docker exec -it taskflow_app php artisan migrate
```

## 🐳 Docker Services

This setup includes the following services:

| Service | Container Name | Port | Description |
|---------|---------------|------|-------------|
| **Apache + PHP** | `taskflow_app` | 8081 | Laravel application server |
| **MySQL 8.0** | `taskflow_db` | 3307 | Database server |
| **phpMyAdmin** | `taskflow_phpmyadmin` | 8082 | Database management interface |

## 📁 Project Structure

```
taskflow-docker-setup/
├── docker/
│   └── apache/
│       └── 000-default.conf    # Apache virtual host configuration
├── docker-compose.yml           # Docker services configuration
├── Dockerfile                   # PHP-Apache container definition
├── setup.sh                     # Automated setup script
└── README.md                    # This file
```

## 🔍 Troubleshooting

### Common Issues and Solutions

#### 1. Permission Denied Errors
If you see errors like "Permission denied" for Laravel logs:
```bash
docker exec -it taskflow_app chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
docker exec -it taskflow_app chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache
```

#### 2. JWT Secret Error
If you get JWT-related errors:
```bash
docker exec -it taskflow_app php artisan jwt:secret
docker exec -it taskflow_app php artisan config:clear
```

#### 3. Database Connection Issues
- Ensure MySQL container is running: `docker ps`
- Check database credentials in `.env` file
- Verify database service is accessible from the app container

#### 4. Port Already in Use
If ports 8081 or 8082 are already in use, modify the ports in `docker-compose.yml`:
```yaml
ports:
  - "8083:80"  # Change 8081 to 8083
```

#### 5. Container Won't Start
Check container logs:
```bash
docker-compose logs app
docker-compose logs db
```

### Useful Docker Commands

```bash
# View running containers
docker ps

# View container logs
docker logs taskflow_app
docker logs taskflow_db

# Access container shell
docker exec -it taskflow_app bash
docker exec -it taskflow_db mysql -u root -p

# Stop all services
docker-compose down

# Stop and remove volumes (WARNING: This will delete all data)
docker-compose down -v

# Rebuild containers
docker-compose build --no-cache
docker-compose up -d
```

## 🛠️ Development Workflow

### 1. Making Code Changes
Your Laravel application code is mounted as a volume, so changes are reflected immediately.

### 2. Installing New PHP Packages
```bash
docker exec -it taskflow_app composer require package-name
```

### 3. Running Artisan Commands
```bash
docker exec -it taskflow_app php artisan migrate
docker exec -it taskflow_app php artisan make:controller ExampleController
```

### 4. Installing Node.js Dependencies (if needed)
```bash
docker exec -it taskflow_app npm install
docker exec -it taskflow_app npm run dev
```

## 🔒 Security Notes

- Change default passwords in the `.env` file
- Never commit `.env` files to version control
- Use strong passwords for database access
- Consider using Docker secrets for production

## 📞 Support

If you encounter issues:

1. Check the troubleshooting section above
2. Verify all prerequisites are installed
3. Ensure Docker Desktop is running
4. Check container logs for specific error messages

## 🎯 Next Steps

After successful setup:

1. Configure your Laravel application settings
2. Set up your database schema
3. Configure authentication (if using JWT)
4. Set up your development workflow
5. Deploy to production (with appropriate security measures)

---

**Happy Coding! 🚀** 