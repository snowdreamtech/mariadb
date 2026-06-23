#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [mariadb] Starting mariadb..."; fi

# mariadbd
# Idempotency guard: Debian's mariadb-server package auto-initializes the
# data directory during apt-get install (via postinst script). Skip re-init
# if the data directory is already populated to avoid 'mysql.user table
# already exists!' warnings.
if [ ! -d "/var/lib/mysql/mysql" ]; then
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

/usr/bin/mariadbd-safe --datadir='/var/lib/mysql' >/dev/null 2>&1 &
mariadbd_safe_pid=$!

# Wait for MariaDB to become ready, with crash detection and timeout guard.
mariadb_wait_secs=0
mariadb_wait_max=120
until [ "$(/usr/bin/mariadb-admin -h localhost -u root -p"${MARIADB_ROOT_PWD}" ping 2>/dev/null)" = 'mysqld is alive' ]; do
  # Crash detection: bail out if mariadbd-safe process has exited
  if ! kill -0 "${mariadbd_safe_pid}" 2>/dev/null; then
    echo "ERROR: mariadbd-safe exited unexpectedly (possible crash or startup failure)."
    exit 1
  fi
  # Timeout guard
  if [ "${mariadb_wait_secs}" -ge "${mariadb_wait_max}" ]; then
    echo "ERROR: MariaDB did not start within ${mariadb_wait_max} seconds."
    exit 1
  fi
  echo "Waiting for MariaDB to start..."
  sleep 1
  mariadb_wait_secs=$((mariadb_wait_secs + 1))
done

/usr/local/bin/mariadb-setup

if [ "$DEBUG" = "true" ]; then echo "→ [mariadb] Mariadb started."; fi
