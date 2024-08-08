#!/bin/sh
set -e

MARIADB_CONFIG_PATH=/etc/my.cnf.d/mariadb-server.cnf

# Modifying configuration file mariadb-server.cnf
# https://wiki.alpinelinux.org/wiki/MySQL
sed -i "s|port\s*=\s*.+|port = ${MARIADB_PORT}|g" ${MARIADB_CONFIG_PATH}
sed -i "s|\#*bind-address\s*=.*|bind_address = 127.0.0.1,::1,db,mysql,mariadb|g" ${MARIADB_CONFIG_PATH}

# Set default charset to UTF8MB4, in newer versions (since Alpine v3.9), 
# just added a new file to added thus customization, 
# but older versions (below Alpine v3.8)of the package does not have a charset section, 
# so you must added manually to the main configuration in each respective section:
cat > /etc/my.cnf.d/mariadb-server-default-charset.cnf << EOF
[client]
default-character-set = utf8mb4

[mysqld]
collation_server = utf8mb4_unicode_ci
character_set_server = utf8mb4

[mysql]
default-character-set = utf8mb4
EOF


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
