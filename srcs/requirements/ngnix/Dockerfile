FROM nginx:latest

# Copiar la configuración personalizada de NGINX
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copiar los certificados SSL (si están en ./ssl)
COPY ssl /etc/ssl

# Exponer el puerto 443 para HTTPS
EXPOSE 443
