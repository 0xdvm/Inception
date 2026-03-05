#!/bin/sh

#  Cria o o diretorio se nao existir
mkdir -p /var/www/html/wordpress

# Vai ate o diretorio 
cd /var/www/html/wordpress

# Baixa o wordpress e no arquivo wp-config.php nao existir
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    
fi

# executa
exec php-fpm83 -F