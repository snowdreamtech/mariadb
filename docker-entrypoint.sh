#!/bin/sh
set -e

# mysqld
(
    sleep 3
    /usr/local/bin/mysql-setup.sh
) &

# mysqld
/usr/bin/mysqld_safe

# exec commands
exec "$@"
