# Usa o apline como base para a imagem do Nginx
FROM alpine:3.22

# Atualiza os repositórios e instala o Nginx sem cache para reduzir o tamanho da imagem
RUN apk update && apk add --no-cache nginx openssl

# Copia o arquivo de configuração do Nginx para o diretório de configuração do Nginx na imagem
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Criando o certificado ssl
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=AO/ST=Luanda/L=Luanda/O=42/CN=$DOMAIN_NAME"

# Expõe a porta 80 para permitir o acesso ao servidor Nginx
EXPOSE 80

# Comando para iniciar o Nginx em primeiro plano, garantindo que o container continue rodando
CMD ["nginx", "-g", "daemon off;"]