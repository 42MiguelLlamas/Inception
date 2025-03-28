# Makefile para entorno WordPress + MariaDB + NGINX con Docker

COMPOSE=docker compose -f srcs/docker-compose.yml

# 🏗️ Construye las 3 imágenes personalizadas
build:
	docker build -t custom-mariadb ./srcs/requirements/mariadb
	docker build -t custom-wordpress ./srcs/requirements/wordpress
	docker build -t custom-nginx ./srcs/requirements/nginx

# 🚀 Levanta todo el stack (primero build, luego compose up)
all: build
	$(COMPOSE) up -d

# 🛑 Detiene todos los contenedores
down:
	$(COMPOSE) down

# 🧹 Elimina contenedores + volúmenes + imágenes personalizadas
clean:
	$(COMPOSE) down -v
	docker rm -f mariadb wordpress nginx || true
	docker image rm -f custom-mariadb custom-wordpress custom-nginx || true

# 🔎 Muestra contenedores activos
status:
	docker ps

# 📦 Reconstruye todo desde cero
rebuild: clean up

logs:
	$(COMPOSE) logs -f --tail=50

bash-nginx:
	docker exec -it nginx bash

# Ejecuta bash dentro del contenedor wordpress
bash-wordpress:
	docker exec -it wordpress bash

# Ejecuta bash dentro del contenedor mariadb
bash-mariadb:
	docker exec -it mariadb bash

# Ejecuta curl -k https://localhost desde dentro de nginx
curl-nginx:
	docker exec nginx curl -k https://localhost

# 💣 Borra absolutamente TODO: contenedores, imágenes, volúmenes y redes personalizadas
nuke:
	@read -p "⚠️  Esto eliminará TODO en Docker. ¿Estás seguro? [y/N]: " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		echo "🧨 Eliminando todos los contenedores..."; \
		docker stop $$(docker ps -qa) 2>/dev/null || true; \
		docker rm $$(docker ps -qa) 2>/dev/null || true; \
		echo "🧨 Eliminando todas las imágenes..."; \
		docker rmi -f $$(docker images -q) 2>/dev/null || true; \
		echo "🧨 Eliminando todos los volúmenes..."; \
		docker volume rm $$(docker volume ls -q) 2>/dev/null || true; \
		echo "🧨 Eliminando todas las redes personalizadas..."; \
		docker network rm $$(docker network ls -q) 2>/dev/null || true; \
		echo "✅ Docker está completamente limpio."; \
	else \
		echo "❌ Cancelado."; \
	fi
