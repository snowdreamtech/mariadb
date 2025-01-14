#!/bin/sh
set -e

# openssl rand -base64 33
if [ -z "${MARIADB_ROOT_PASSWORD}" ]; then
    {
        MARIADB_ROOT_PASSWORD=$(openssl rand -base64 33)
        echo " Generate Random mariadb root password:${MARIADB_ROOT_PASSWORD}"
    }
fi

# Modifying configuration file mariadb-server.cnf
# https://wiki.alpinelinux.org/wiki/MySQL
sed -i "s|\#*\s*port\s*=\s*.*|port = ${MARIADB_PORT}|g" /etc/mysql/my.cnf
# sed -i "s|\#*bind-address\s*=.*|bind_address = 127.0.0.1,::1,db,mysql,mariadb|g" /etc/mysql/mariadb.conf.d/50-server.cnf
if [ "${DISALLOW_ROOT_LOGIN_REMOTELY}" -eq 0 ] || [ "${DISALLOW_USER_LOGIN_REMOTELY}" -eq 0 ] ; then
    sed -i "s|\#*bind-address\s*=.*|bind_address = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf
fi
sed -i "/\#*skip-networking/d" /etc/mysql/mariadb.conf.d/50-server.cnf

# Set default charset to UTF8MB4, in newer versions (since Alpine v3.9),
# just added a new file to added thus customization,
# but older versions (below Alpine v3.8)of the package does not have a charset section,
# so you must added manually to the main configuration in each respective section:
cat >/etc/mysql/mariadb.conf.d/mariadb-server-default-charset.cnf <<EOF
[client]
default-character-set = utf8mb4

[mysqld]
collation_server = utf8mb4_unicode_ci
character_set_server = utf8mb4

[mysql]
default-character-set = utf8mb4
EOF

# mysqld
mariadb-install-db --user=mysql --datadir=/var/lib/mysql

/usr/bin/mariadbd-safe --datadir='/var/lib/mysql' >/dev/null 2>&1 &

until [ "$(/usr/bin/mariadb-admin -h localhost -u root -p${MARIADB_ROOT_PASSWORD} ping 2>/dev/null)" = 'mysqld is alive' ]; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

/usr/local/bin/mariadb-setup

# exec commands
if [ -n "$*" ]; then
    sh -c "$*"
fi

# keep the docker container running
# https://github.com/docker/compose/issues/1926#issuecomment-422351028
if [ "${KEEPALIVE}" -eq 1 ]; then
    trap : TERM INT
    tail -f /dev/null &
    wait
    # sleep infinity & wait
fi
