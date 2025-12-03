#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [mariadb] Starting mariadb..."; fi

# mysqld
mariadb-install-db --user=mysql --datadir=/var/lib/mysql

/usr/bin/mariadbd-safe --datadir='/var/lib/mysql' >/dev/null 2>&1 &

# Wait for MariaDB to start (initially with no password)
until [ "$(/usr/bin/mariadb-admin -h localhost -u root ping 2>/dev/null)" = 'mysqld is alive' ]; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

/usr/local/bin/mariadb-setup

if [ "$DEBUG" = "true" ]; then echo "→ [mariadb] Mariadb started."; fi
