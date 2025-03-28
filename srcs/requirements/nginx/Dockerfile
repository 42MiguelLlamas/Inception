# Imagen base mínima y estable
FROM debian:bullseye

# Instalar NGINX y OpenSSL
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copiar configuración personalizada de NGINX
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# Copiar los certificados SSL autofirmados
COPY fullchain.pem /etc/ssl/certs/
COPY privkey.pem /etc/ssl/private/

# Exponer el puerto HTTPS
EXPOSE 443

# Comando por defecto
CMD ["nginx", "-g", "daemon off;"]
