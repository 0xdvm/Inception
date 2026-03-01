#!/bin/bash

set -e # Para o script se algum comando falhar

# Verifica se o diretório de dados do MySQL está vazio
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysqld --initialize-insecure --user=root
    mysqld_safe &

    sleep 5 # Espera o servidor iniciar


# Configura o MySQL com as variáveis de ambiente
mysql -u root << EOF 
CREATE DATABASE ${MYSQL_DATABASE};
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Define a senha do root
mysqladmin -u root password $MYSQL_ROOT_PASSWORD
fi

# Inicia o servidor MySQL
exec mysqld_safe
