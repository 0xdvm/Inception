# Imagem base do alpine
FROM alpine:3.22

# Atualizando os pacotes e instalando o php, php-fpm e as extensoes necessaria
RUN apk update && apk add --no-cache php php-fpm php-mysqli php-json php-session \
php-opcache php-gd php-curl php-xml php-mbstring php-zip php-phar \
wget tar mysql-client

# Baixando os arquivos do wordpress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz
    
# cria diretório se não existir e move WordPress
RUN mkdir -p /var/www/html && mv wordpress /var/www/html

# Cria usuário www-data
RUN getent group www-data || addgroup -S www-data \
 && id -u www-data || adduser -S -G www-data www-data

# Copia o arquivo www.conf para o diretorio indicado
COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf

# Copia o arquivo php.ini para o php83/
COPY ./conf/php.ini /etc/php83/php.ini

# Baixa o wp-cli.phar para ajudar a configurar e baixar os arquivos do wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Altera as permissoes do arquivo wp-cli.phar e move ela para o diretorio /usr/local/bin/wp para que funciona o comando 'wp'
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Copia o script de inicializacao para /usr/local/bin/
COPY ./init.sh /usr/local/bin/init.sh

# Removendo as permissoes o script de configuracao. 
RUN chmod +x /usr/local/bin/init.sh

# Expoe a porta onde o serivico ira rodar
EXPOSE 9000

# Executa o script 
ENTRYPOINT [ "/usr/local/bin/init.sh" ]
# CMD sh