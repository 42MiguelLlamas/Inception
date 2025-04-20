FROM debian:bullseye

# Instalamos PHP, FPM y extensiones necesarias para WordPress
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-zip wget unzip curl && \
    rm -rf /var/lib/apt/lists/*

# Creamos directorio de trabajo donde estará WordPress
WORKDIR /var/www/html

# Descargamos y extraemos WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

RUN chown -R www-data:www-data /var/www/html
RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Exponemos el puerto 9000
EXPOSE 9000

# Comando por defecto: arrancar el servidor PHP-FPM en primer plano
CMD ["php-fpm7.4", "-F"]
