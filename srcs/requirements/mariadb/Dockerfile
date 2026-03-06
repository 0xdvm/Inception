# Usar a penultima versao do apline com imagem base 
FROM alpine:3.22

# Atualiza pacotes, instala MariaDB e limpa cache do apk
RUN apk update && \
    apk add --no-cache mariadb mariadb-client && \
    rm -f /var/cache/apk/* 

# Copiar o arquivo de configuracao 50-server.cnf para a pasta indicada.
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copiar o aruivo entrypoint.sh para o diretorio /usr/local/bin
COPY ./init.sh /usr/local/bin/init.sh

# Removendo as permissoes o script de configuracao. 
RUN chmod +x /usr/local/bin/init.sh

EXPOSE 3306

# Rodando o script de configuracao.
ENTRYPOINT [ "/usr/local/bin/init.sh" ]