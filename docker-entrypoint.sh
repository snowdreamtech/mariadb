#!/bin/sh
set -e

MARIADB_CONFIG_PATH=/etc/my.cnf.d/mariadb-server.cnf

# Modifying configuration file mariadb-server.cnf
sed -i "s|port\s*=\s*|port = ${MARIADB_PORT}|g" ${MARIADB_CONFIG_PATH}

# mysqld
(
    sleep 3
    /usr/local/bin/mariadb-setup.sh
) &

# mysqld
mysql_install_db --user=mysql --datadir=/var/lib/mysql
/usr/bin/mysqld_safe

# exec commands
exec "$@"
