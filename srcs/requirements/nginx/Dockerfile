# Usa o apline como base para a imagem do Nginx
FROM alpine:3.22

# Atualiza os repositórios e instala o Nginx sem cache para reduzir o tamanho da imagem
RUN apk update && apk add --no-cache nginx

# Copia o arquivo de configuração do Nginx para o diretório de configuração do Nginx na imagem
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expõe a porta 80 para permitir o acesso ao servidor Nginx
EXPOSE 80

# Comando para iniciar o Nginx em primeiro plano, garantindo que o container continue rodando
CMD ["nginx", "-g", "daemon off;"]