#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [mariadb] Starting mariadb..."; fi

# mariadbd
# Idempotency guard: Debian's mariadb-server package auto-initializes the
# data directory during apt-get install (via postinst script). Skip re-init
# if the data directory is already populated to avoid 'mysql.user table
# already exists!' warnings.
if [ ! -d "/var/lib/mysql/mysql" ]; then
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

/usr/bin/mariadbd-safe --datadir='/var/lib/mysql' >/dev/null 2>&1 &

until [ "$(/usr/bin/mariadb-admin -h localhost -u root -p"${MARIADB_ROOT_PWD}" ping 2>/dev/null)" = 'mysqld is alive' ]; do
  echo "Waiting for MariaDB to start..."
  sleep 1
done

/usr/local/bin/mariadb-setup

if [ "$DEBUG" = "true" ]; then echo "→ [mariadb] Mariadb started."; fi
