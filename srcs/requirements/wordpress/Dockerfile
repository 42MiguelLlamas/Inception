# Usamos como base Debian estable (bullseye)
FROM debian:bullseye

# Desactivamos la interacción durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Instalamos PHP, FPM y extensiones necesarias para WordPress
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip wget unzip curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Creamos directorio de trabajo donde estará WordPress
WORKDIR /var/www/html

# Descargamos y extraemos WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

# Creamos el directorio necesario para el socket de php-fpm
RUN mkdir -p /run/php

# 🔧 Creamos un alias para php-fpm → php-fpm7.4
RUN ln -s /usr/sbin/php-fpm7.4 /usr/sbin/php-fpm

# Exponemos el puerto 9000
EXPOSE 9000

# Comando por defecto: arrancar el servidor PHP-FPM en primer plano
CMD ["php-fpm", "-F"]
