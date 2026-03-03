#!/bin/sh

MYSQL_ROOT_PASSWORD=$(cat $MYSQL_ROOT_PASSWORD_FILE)
MYSQL_PASSWORD=$(cat $MYSQL_PASSWORD_FILE)

MYSQL_DATADIR=/var/lib/mysql

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql $MYSQL_DATADIR

if [ ! -d "$MYSQL_DATADIR/mysql" ]; then
    echo "Instalando tabelas de sistema do MariaDB..."
    mariadb-install-db --user=mysql --datadir=$MYSQL_DATADIR > /dev/null
fi

if [ ! -d "$MYSQL_DATADIR/$MYSQL_DATABASE" ]; then
    echo "Iniciando configuração inicial..."
    mariadbd --user=mysql --skip-networking &
    pid="$!"

    until mariadb-admin ping --silent; do
        echo "Aguardando MariaDB subir..."
        sleep 1
    done

    echo "\n\n\n a senha e eesta: $MYSQL_PASSWORD \n\n\n"
    mariadb -u root << EOF
        FLUSH PRIVILEGES;
        ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOF
    kill "$pid"
    wait "$pid"
fi

echo "MariaDB pronto para conexões!"
exec mariadbd --user=mysql