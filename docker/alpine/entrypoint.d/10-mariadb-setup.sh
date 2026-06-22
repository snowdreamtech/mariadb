#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [mariadb] Setting up mariadb..."; fi

# openssl rand -base64 33
if [ -z "${MARIADB_ROOT_PWD}" ]; then
    {
        MARIADB_ROOT_PWD=$(openssl rand -base64 33)
        echo "Generate Random mariadb root password:   ${MARIADB_ROOT_PWD}"
    }
fi

# Modifying configuration file mariadb-server.cnf
# https://wiki.alpinelinux.org/wiki/MySQL
sed -i "s|port\s*=\s*.+|port = ${MARIADB_PORT}|g" /etc/my.cnf.d/mariadb-server.cnf
# sed -i "s|\#*bind-address\s*=.*|bind_address = 127.0.0.1,::1,db,mysql,mariadb|g" /etc/my.cnf.d/mariadb-server.cnf
if [ "${DISALLOW_ROOT_LOGIN_REMOTELY}" -eq 0 ] || [ "${DISALLOW_USER_LOGIN_REMOTELY}" -eq 0 ] ; then
    sed -i "s|\#*bind-address\s*=.*|bind_address = 0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
fi
sed -i "/\#*skip-networking/d" /etc/my.cnf.d/mariadb-server.cnf

# Set default charset to UTF8MB4, in newer versions (since Alpine v3.9),
# just added a new file to added thus customization,
# but older versions (below Alpine v3.8)of the package does not have a charset section,
# so you must added manually to the main configuration in each respective section:
cat >/etc/my.cnf.d/mariadb-server-default-charset.cnf <<EOF
[client]
default-character-set = utf8mb4

[mysqld]
collation_server = utf8mb4_unicode_ci
character_set_server = utf8mb4

[mysql]
default-character-set = utf8mb4
EOF

if [ "$DEBUG" = "true" ]; then echo "→ [mariadb] Mariadb has been set up."; fi    
