#!/bin/sh
set -e

# mysqld
/usr/bin/mysqld_safe --user=mysql --defaults-file=/etc/my.cnf 

# exec commands
exec "$@"
