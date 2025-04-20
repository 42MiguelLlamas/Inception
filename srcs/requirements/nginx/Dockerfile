
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/key.pem \
    -out /etc/ssl/private/cert.pem \
    -subj "/C=ES/ST=Madrid/L=Madrid/O=42/CN=mllamas.42.fr" 

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
