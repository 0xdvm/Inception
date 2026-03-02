# Usar a penultima versao do apline com imagem base 
FROM alpine:3.22

# Instalar o mariadb dentro dele
RUN apk add --no-cache mariadb bash

# Copiar o arquivo de configuracao 50-server.cnf para a pasta indicada.
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

#Copiar o aruivo entrypoint.sh para o diretorio /usr/local/bin
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

#Removvendo as permissoes o script de configuracao. 
RUN chmod +x /usr/local/bin/entrypoint.sh

#Rodando o script de configuracao.
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]