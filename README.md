*This project has been created as part of the 42 curriculum by dvemba.*

# Inception Project

## Description

The **Inception** project aims to deploy a complete web infrastructure
using **Docker**.\
The infrastructure includes **Nginx**, **WordPress**, and **MariaDB**,
each running in its own container and orchestrated using **Docker
Compose**.

The main goal of the project is to demonstrate how containerization can
simplify application deployment, ensure reproducibility, and isolate
services in a clean and maintainable architecture.

The project implements: - **Nginx** as the web server and reverse
proxy - **WordPress** as the application layer - **MariaDB** as the
database - **Docker Compose** to orchestrate all services

Each service is containerized separately and communicates through a
dedicated Docker network.

------------------------------------------------------------------------

## Project Structure

```
.
├── DEV_DOC.md
├── Makefile
├── README.md
├── secrets
│   ├── mysql_root_password.txt
│   ├── mysql_user_password.txt
│   ├── wp_admin_password.txt
│   └── wp_user_password.txt
├── srcs
│   ├── docker-compose.yml
│   └── requirements
│       ├── mariadb
│       │   ├── conf
│       │   │   └── mariadb-server.cnf
│       │   ├── Dockerfile
│       │   └── init.sh
│       ├── nginx
│       │   ├── conf
│       │   │   └── nginx.conf
│       │   └── Dockerfile
│       └── wordpress
│           ├── conf
│           │   ├── php.ini
│           │   └── www.conf
│           ├── Dockerfile
│           └── init.sh
└── USER_DOC.md

```

This structure separates each service configuration clearly, improving
maintainability and modularity.

------------------------------------------------------------------------

## Instructions

### Requirements

Before running the project, make sure the following programs
are installed:

-   Docker
-   Docker Compose
-   GNU Make
-   Git

You can check the versions with:

``` bash
docker --version
docker compose version
make --version
git --version
```

------------------------------------------------------------------------

### Clone the Project

Clone the repository:

``` bash
git clone <repository_url>
```

Enter the project folder:

``` bash
cd Inception
```

------------------------------------------------------------------------

### Project Preparation

Before starting the containers, the project creates the necessary directories
to store persistent data.

These directories store:

-   MariaDB database files
-   WordPress files

They are created in:

/home/dvemba/data/

This step is performed automatically by **Makefile**.

------------------------------------------------------------------------

### Building and Starting the Containers

To build the images and start the containers:

``` bash
make build
```

This command will:

1.  Create the directories:

/home/dvemba/data/mariadb\
/home/dvemba/data/wordpress

2.  Set appropriate permissions

3.  Build the Docker images

4.  Start the containers in the background

------------------------------------------------------------------------

### Start Containers (without rebuilding)

If the containers already exist:

``` bash
make up
```

------------------------------------------------------------------------

### Stop the Project

``` bash
make down
```

or

``` bash
docker compose -f srcs/docker-compose.yml down
```

------------------------------------------------------------------------

### Reset the Project (Remove Volumes)

Useful for restarting the database:

``` bash
make down-volumes
```

------------------------------------------------------------------------

### Remove Everything (Containers + Volumes + Images)

``` bash
make down-all
```

------------------------------------------------------------------------

### View Logs

Logs for all services:

``` bash
make logs
```

Logs for a specific service:

``` bash
make logs-nginx
make logs-wordpress
make logs-mariadb
```

------------------------------------------------------------------------

### View Running Containers

``` bash
make ps
```

------------------------------------------------------------------------

### Run Commands Inside a Container

Open shell inside a container:

``` bash
make exec-nginx
make exec-wordpress
make exec-mariadb
```

------------------------------------------------------------------------

### Stop Containers Without Removing Them

``` bash
make stop
```

Stop a specific service:

``` bash
make stop-nginx
make stop-wordpress
make stop-mariadb
```

------------------------------------------------------------------------

### Clean Up Stopped Containers

``` bash
make clean
```

------------------------------------------------------------------------

### Accessing the Website

After starting the containers, the site can be accessed through the configured domain.

Example:

https://dvemba.42.fr

Make sure the domain is configured in the file
`/etc/hosts`.

Example:

127.0.0.1 dvemba.42.fr

------------------------------------------------------------------------

## Docker Design Choices

### Virtual Machines vs Docker

  Virtual Machines              Docker
  ----------------------------- -------------------------
  Run full operating systems    Share the host kernel
  Higher resource consumption   Lightweight
  Slower startup time           Very fast startup
  Strong isolation              Process-level isolation

Docker was chosen because it allows faster deployment, lower resource
usage, and easier environment replication.

------------------------------------------------------------------------

### Secrets vs Environment Variables

  Environment Variables           Secrets
  ------------------------------- ---------------------
  Easy to use                     More secure
  Visible in container metadata   Stored securely
  Often stored in plain text      Injected at runtime

In this project, **Docker Secrets** are used to store sensitive data
such as database passwords.

The secrets are stored in the `secrets/` directory and mounted inside
containers.

------------------------------------------------------------------------

### Docker Network vs Host Network

  Host Network                       Docker Network
  ---------------------------------- ----------------------------
  Containers share host networking   Isolated networking
  Less secure                        Better service isolation
  No internal DNS                    Built‑in service discovery

This project uses a **Docker bridge network**, allowing containers to
communicate using their service names.

Example: - WordPress connects to MariaDB using `mariadb` as the
hostname.

------------------------------------------------------------------------

### Docker Volumes vs Bind Mounts

  Bind Mounts                  Docker Volumes
  ---------------------------- ---------------------------
  Linked to host directories   Managed by Docker
  Less portable                More portable
  Useful for development       Ideal for persistent data

Docker **volumes** are used in this project to store persistent data
such as:

-   WordPress files
-   MariaDB database files

This ensures data is not lost when containers are recreated.

------------------------------------------------------------------------

## Resources

### Documentation

Docker Documentation\
https://docs.docker.com/

Docker Compose Documentation\
https://docs.docker.com/compose/

Nginx Documentation\
https://nginx.org/en/docs/

MariaDB Documentation\
https://mariadb.com/kb/

WordPress Documentation\
https://wordpress.org/support/

------------------------------------------------------------------------

### AI Usage

Artificial Intelligence tools were used for:

-   Structuring and formatting the README file
-   Clarifying Docker concepts and architecture decisions
-   Improving documentation clarity

AI was **not used to generate the core project implementation**, only
for documentation assistance and explanations.

------------------------------------------------------------------------

## Final Notes

This project demonstrates:

-   Containerized infrastructure
-   Service orchestration with Docker Compose
-   Secure secret management
-   Network isolation between services
-   Persistent storage with Docker volumes

The architecture reflects modern DevOps practices and reproducible
development environments.
