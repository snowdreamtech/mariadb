#!/bin/sh
set -e

MARIADB_CONFIG_PATH=/etc/my.cnf.d/mariadb-server.cnf


# openssl rand -base64 33
if [ -z "${MARIADB_ROOT_PASSWORD}" ]; then {
    MARIADB_ROOT_PASSWORD=$(openssl rand -base64 33)
    echo " Generate Random mariadb root password:${MARIADB_ROOT_PASSWORD}"
}
fi

# Modifying configuration file mariadb-server.cnf
# https://wiki.alpinelinux.org/wiki/MySQL
sed -i "s|port\s*=\s*.+|port = ${MARIADB_PORT}|g" ${MARIADB_CONFIG_PATH}
# sed -i "s|\#*bind-address\s*=.*|bind_address = 127.0.0.1,::1,db,mysql,mariadb|g" ${MARIADB_CONFIG_PATH}
#sed -i "s|\#*bind-address\s*=.*|bind_address = 0.0.0.0|g" ${MARIADB_CONFIG_PATH}
#sed -i "/\#*skip-networking/d" ${MARIADB_CONFIG_PATH}


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
    /usr/local/bin/mariadb-setup
) &

# mysqld
if [ ! -d "/var/lib/mysql" ];then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
else
    echo "/var/lib/mysql exists."
fi
/usr/bin/mysqld_safe

# exec commands
exec "$@"
