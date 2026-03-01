# Usar a penultima versao do apline com imagem base 
FROM apline:3.22

# Instalar o mariadb dentro dele
RUN apk add mariadb

# Copiar o arquivo de configuracao 50-server.cnf para a pasta indicada.
COPY ./conf/50-server.cnf ./etc/mysql/mariadb.conf.d/

#Removvendo as permissoes o script de configuracao. 
RUN ["chmod", "+x", "entrypoint.sh"]

#Rodando o script de configuracao.
ENTRYPOINT [ "./entrypoint.sh" ]