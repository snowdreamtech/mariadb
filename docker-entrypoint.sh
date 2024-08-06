#!/bin/sh
set -e

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
