#!/bin/sh

# # Espera até MariaDB responder
# until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASS" -e "select 1" >/dev/null 2>&1; do
#   echo "Aguardando MariaDB..."
#   sleep 2
# done

WP_DIR=/var/www/html/wordpress
#  Cria o o diretorio se nao existir
mkdir -p $WP_DIR

# Vai ate o diretorio 
cd $WP_DIR

# Baixa o wordpress e no arquivo wp-config.php nao existir
if [ ! -f wp-config.php ]; then

    # Busca a senha do bancod e dados atraves da variavel de ambiente.
    DB_PASS=$(cat $MYSQL_PASSWORD_FILE)

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

    # 


fi

# executa
exec php-fpm83 -F