#!/bin/sh

# Pega os valores que estao nas variaveis de ambientes que apontam para um arquivo
DB_PASS=$(cat $MYSQL_PASSWORD_FILE)
WP_ADMIN_PASS=$(cat $WP_ADMIN_PASSWORD_FILE)
WP_USER_PASS=$(cat $WP_USER_PASSWORD_FILE)

# Espera até MariaDB responder
until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASS" -e "select 1" >/dev/null 2>&1; do
  echo "Aguardando MariaDB..."
  sleep 2
done

WP_DIR=/var/www/html/wordpress
#  Cria o o diretorio se nao existir
mkdir -p $WP_DIR

# Vai ate o diretorio 
cd $WP_DIR

# Baixa o wordpress e no arquivo wp-config.php nao existir
if [ ! -f wp-config.php ]; then


    # Baixa os arquivos do wordpress
    # wp core download --allow-root

    # Cria o arquivo de configuracao com todas informacoes do banco de dados
    wp config create \
    --dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$DB_PASS \
    --dbhost=$DB_HOST \
    --skip-check \
    --allow-root

    # Instala o wordpress com as configuracoes do admin
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    # Cria um usuario normal
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
    --user_pass=$WP_USER_PASS \
    --allow-root

fi

# executa
exec php-fpm83 -F