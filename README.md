# TaskFlow - Laravel Docker Setup

This repository contains the Docker setup for running the **TaskFlow** Laravel application in a containerized local development environment.

## 🚀 Services

- **Apache + PHP** (for Laravel)
- **MySQL 8.0**
- **phpMyAdmin**

## 🐳 How to Run

1. **Clone the Repositories**

   Clone both the Docker setup repository and the Laravel project (`taskflow`) into separate folders on your machine.

2. **Update the Volume Path**

   In the `docker-compose.yml` file, update this line:

   ```yaml
   - D:\taskflow:/var/www/html

3. **Update the .env**

   From the root of this repo, copy the `.env.example` file and named it `.env`
   Then update the credentials inside .env if necessary.

