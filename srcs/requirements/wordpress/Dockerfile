# Imagem base do alpine
FROM alpine:3.22

# Atualizando os pacotes e instalando o php, php-fpm e as extensoes necessaria
RUN apk update && apk add php php-fpm php-mysqli php-json php-session \
php-opcache php-gd php-curl php-xml php-mbstring php-zip \
wget tar

# remove se existir
RUN rm -f latest.tar.gz

# cria diretório se não existir e move WordPress
RUN mkdir -p /var/www/html && mv wordpress /var/www/html


