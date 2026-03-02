
#!/bin/bash
set -e

MYSQL_DATADIR=/var/lib/mysql
SOCKET_DIR=/run/mysqld

echo "[INFO] Criando diretório de socket: $SOCKET_DIR"
mkdir -p "$SOCKET_DIR"
chown -R mysql:mysql "$SOCKET_DIR"
chmod 755 "$SOCKET_DIR"

# Inicializa MariaDB se ainda não houver dados
if [ ! -d "$MYSQL_DATADIR/mysql" ]; then
    echo "[INFO] Inicializando MariaDB..."
    mysqld --initialize-insecure --user=mysql --datadir="$MYSQL_DATADIR"
fi

# Inicia MariaDB em background
mysqld_safe --datadir="$MYSQL_DATADIR" --socket="$SOCKET_DIR/mysqld.sock" &
pid="$!"

# Espera até o servidor ficar pronto
echo "[INFO] Aguardando MariaDB iniciar..."
until mysqladmin ping &>/dev/null; do
    sleep 1
done

# Cria banco e usuário se não existir
echo "[INFO] Criando banco e usuário se necessário..."
mysql <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "[INFO] MariaDB iniciado. Mantendo processo em foreground..."
wait "$pid"