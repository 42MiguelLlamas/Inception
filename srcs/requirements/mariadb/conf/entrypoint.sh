#!/bin/bash
set -e
DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}
DB_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
DATADIR="/var/lib/mysql"
# Solo inicializa si es la primera vez
if [ ! -d "$DATADIR/mysql" ]; then
  echo "Inicializando base de datos..."
  mysqld --initialize-insecure --user=mysql --datadir="$DATADIR"
  mysqld_safe --skip-networking &
  sleep 5
  echo "Configurando usuarios..."
  mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    CREATE USER IF NOT EXISTS 'editor'@'%' IDENTIFIED BY 'comentarios2025';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO 'editor'@'%';
    FLUSH PRIVILEGES;
EOSQL
  if [ -f /docker-entrypoint-initdb.d/initdb.sh ]; then
    echo "Ejecutando initdb.sh..."
    mysql -u root "${DB_NAME}" < /docker-entrypoint-initdb.d/initdb.sh
  fi
  killall mysqld || true
  sleep 3
fi
# Arranca el proceso principal (MariaDB)
exec "$@"