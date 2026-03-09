# User Documentation

## Overview

This project deploys a complete web stack using Docker containers.
The stack provides a **WordPress website** running behind an **Nginx web server** and using **MariaDB** as the database.

The services included in the stack are:

* **Nginx** – Web server that handles HTTPS connections.
* **WordPress** – Content management system used to create and manage the website.
* **MariaDB** – Database used to store WordPress data.

All services run inside Docker containers and are orchestrated using **Docker Compose**.

---

# Starting and Stopping the Project

## Start the project

To start the stack, run:

```bash
make build
```

This command will:

* Build Docker images
* Create necessary directories for persistent data
* Start all containers in the background

If the containers already exist, you can start them with:

```bash
make up
```

---

## Stop the project

To stop the containers:

```bash
make down
```

---

# Accessing the Website

Once the containers are running, the website can be accessed through the configured domain.

Example:

```text
https://dvemba.42.fr
```

Make sure that the domain is defined in your `/etc/hosts` file:

```text
127.0.0.1 dvemba.42.fr
```

---

# Accessing the Administration Panel

To access the WordPress administration panel, navigate to:

```text
https://dvemba.42.fr/wp-admin
```

Login using the **WordPress administrator credentials** defined in the secrets.

---

# Managing Credentials

Sensitive credentials such as database and WordPress passwords are stored in the `secrets` directory.

Example:

```text
secrets/
├── mysql_root_password.txt
├── mysql_user_password.txt
├── wp_admin_password.txt
└── wp_user_password.txt
```

These files are read by the containers during startup and used to configure the services.

---

# Checking if Services Are Running

To verify that the containers are running:

```bash
make ps
```

You can also view logs from all services:

```bash
make logs
```

Or logs from a specific service:

```bash
make logs-nginx
make logs-wordpress
make logs-mariadb
```

If all containers are running and no errors appear in the logs, the stack is operating correctly.
