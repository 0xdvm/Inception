# Usar a penultima versao do apline com imagem base 
FROM debian:bookworm-slim

# Atualiza pacotes, instala MariaDB e limpa cache do apt
RUN apt update && \
    apt install -y mariadb-server mariadb-client && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Copiar o arquivo de configuracao 50-server.cnf para a pasta indicada.
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

#Copiar o aruivo entrypoint.sh para o diretorio /usr/local/bin
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

#Removvendo as permissoes o script de configuracao. 
RUN chmod +x /usr/local/bin/entrypoint.sh

#Rodando o script de configuracao.
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]