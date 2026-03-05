#!/bin/sh

MYSQL_ROOT_PASSWORD=$(cat $MYSQL_ROOT_PASSWORD_FILE)
DB_PASSWORD=$(cat $MYSQL_PASSWORD_FILE)

MYSQL_DATADIR=/var/lib/mysql

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql $MYSQL_DATADIR

FIRST_RUN=0

if [ ! -d "$MYSQL_DATADIR/mysql" ]; then
    echo "Instalando tabelas de sistema do MariaDB..."
    mariadb-install-db --user=mysql --datadir=$MYSQL_DATADIR > /dev/null
    FIRST_RUN=1
fi

if [ "$FIRST_RUN" -eq 1 ]; then
    echo "Iniciando configuração inicial..."
    mariadbd --user=mysql --skip-networking &
    pid="$!"

    until mariadb-admin ping --silent; do
        echo "Aguardando MariaDB subir..."
        sleep 1
    done

    # echo "\n\n\n a senha e eesta: $MYSQL_PASSWORD \n\n\n"
    mariadb -u root <<EOF
        FLUSH PRIVILEGES;

        ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

        CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;

        CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '$DB_PASSWORD';
        GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';

        CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
        GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'localhost';

        DELETE FROM mysql.user WHERE User='';
        DROP DATABASE IF EXISTS test;
        
        FLUSH PRIVILEGES;
EOF
    kill "$pid"
    wait "$pid"
fi

echo "MariaDB pronto para conexões!"
exec mariadbd --user=mysql