# Developer Documentation

## Environment Setup

To set up the project environment from scratch, you must first install the required tools.

### Prerequisites

* Docker
* Docker Compose
* GNU Make
* Git

Verify installation:

```bash
docker --version
docker compose version
make --version
git --version
```

---

# Project Structure

```
.
├── Makefile
├── secrets
│   ├── mysql_root_password.txt
│   ├── mysql_user_password.txt
│   ├── wp_admin_password.txt
│   └── wp_user_password.txt
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        │   ├── conf
        │   │   └── mariadb-server.cnf
        │   ├── Dockerfile
        │   └── init.sh
        ├── nginx
        │   ├── conf
        │   │   └── nginx.conf
        │   └── Dockerfile
        └── wordpress
            ├── conf
            │   ├── php.ini
            │   └── www.conf
            ├── Dockerfile
            └── init.sh
```

Each service has its own directory containing:

* Dockerfile
* Configuration files
* Initialization scripts

---

# Building and Launching the Project

To build and start the containers:

```bash
make build
```

This command will:

* Create the required data directories
* Build Docker images
* Launch containers using Docker Compose

If images are already built:

```bash
make up
```

---

# Managing Containers

Useful commands provided by the Makefile:

### Stop containers

```bash
make down
```

### Remove containers and volumes

```bash
make down-volumes
```

### Remove containers, volumes and images

```bash
make down-all
```

---

# Viewing Logs

Logs from all services:

```bash
make logs
```

Logs from a specific service:

```bash
make logs-nginx
make logs-wordpress
make logs-mariadb
```

---

# Accessing Containers

To execute commands inside a container:

```bash
make exec-nginx
make exec-wordpress
make exec-mariadb
```

This opens an interactive shell inside the selected container.

---

# Data Persistence

Project data is stored outside containers to ensure persistence.

The following directories are created automatically:

```text
/home/dvemba/data/mariadb
/home/dvemba/data/wordpress
```

These directories are mounted as **Docker volumes**, allowing data to remain even if containers are recreated.

Stored data includes:

* MariaDB database files
* WordPress uploaded content and configuration
