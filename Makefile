# Nome dos serviços
COMPOSE = @cd srcs && docker compose
SERVICES = mariadb wordpress nginx

# -------------------------------
# Comandos principais
# -------------------------------

# Reconstrói as imagens e inicia os containers
build:
	$(COMPOSE) up -d --build

# Inicia todos os containers em background
up:
	$(COMPOSE) up -d

# Para os containers
down:
	$(COMPOSE) down

# Para containers e remove volumes (útil para reset do banco)
down-volumes:
	$(COMPOSE) down -v

# Para containers e remove imagens
down-all:
	$(COMPOSE) down -v --rmi all

# Mostra logs de todos os serviços
logs:
	$(COMPOSE) logs -f

# Mostra logs de um serviço específico
logs-%:
	$(COMPOSE) logs -f $*

# Lista todos os containers
ps:
	$(COMPOSE) ps

# Para os containers mas mantem volumes e imagens
stop:
	$(COMPOSE) stop

# Parar um serviço específico
stop-%:
	$(COMPOSE) stop $*

# Executa um comando dentro de um container
exec-%:
	$(COMPOSE) exec $* sh

# Remove containers parados
clean:
	$(COMPOSE) rm -f