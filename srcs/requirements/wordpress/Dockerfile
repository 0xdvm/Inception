# Imagem base do alpine
FROM alpine:3.22

# Atualizando os pacotes e instalando o php, php-fpm e as extensoes necessaria
RUN apk update && apk add --no-cache php php-fpm php-mysqli php-json php-session \
php-opcache php-gd php-curl php-xml php-mbstring php-zip \
wget tar

# Cria usuário www-data (Alpine não tem por padrão)
# RUN addgroup -S www-data && adduser -S -G www-data www-data

# Baixa e descompacta o wordpress e depois remove o .tar.gz
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz
    
# cria diretório se não existir e move WordPress
RUN mkdir -p /var/www/html && mv wordpress /var/www/html

# Copia o arquivio de configuracao do wordpress para pasta padrao no wordpress
COPY ./conf/wp-config.php /var/www/html/wordpress/wp-config.php

# Ajustar o dono e permissoes
RUN id -u www-data || addgroup -S www-data \
 && id -u www-data || adduser -S -G www-data www-data \
 && mkdir -p /var/www/html \
 && chown -R www-data:www-data /var/www/html \
 && find /var/www/html -type d -exec chmod 755 {} \; \
 && find /var/www/html -type f -exec chmod 644 {} \;

# Copia o arquivo www.conf para o diretorio indicado
COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm83", "-F"]