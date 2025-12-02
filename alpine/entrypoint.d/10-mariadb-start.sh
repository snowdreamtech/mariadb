#!/bin/sh
set -e

# mysqld
mariadb-install-db --user=mysql --datadir=/var/lib/mysql

/usr/bin/mariadbd-safe --datadir='/var/lib/mysql' >/dev/null 2>&1 &

until [ "$(/usr/bin/mariadb-admin -h localhost -u root -p${MARIADB_ROOT_PASSWORD} ping 2>/dev/null)" = 'mysqld is alive' ]; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

/usr/local/bin/mariadb-setup
