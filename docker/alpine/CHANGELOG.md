# Changelog

## [11.8.8](https://github.com/snowdreamtech/mariadb/compare/alpine-v11.8.8...alpine-v11.8.8) (2026-06-23)


### 🐛 Bug Fixes

* add crash detection and timeout guard to MariaDB startup loop ([190ce4f](https://github.com/snowdreamtech/mariadb/commit/190ce4fdb3893eaef1aab69b1184c41c34d3e13f))
* **alpine,rocky:** add idempotency guard for mariadb-install-db ([bb33049](https://github.com/snowdreamtech/mariadb/commit/bb330499c283321a602dc622fd2a4843ca8bfa42))
* **alpine:** create /run/mysqld directory before starting mariadbd ([38104d6](https://github.com/snowdreamtech/mariadb/commit/38104d64a5b9cf086d3c0bd19df4dde7f73ac125))
* guard stty calls with TTY check to prevent CI smoke test failure ([b58652b](https://github.com/snowdreamtech/mariadb/commit/b58652b4fa7dec8c784bef00d380611a82bf5849))

## [11.8.8](https://github.com/snowdreamtech/mariadb/compare/alpine-v11.8.8...alpine-v11.8.8) (2026-06-23)


### 🐛 Bug Fixes

* **docker:** replace \r with \n in expect scripts to fix rocky build hang ([ca1a9c2](https://github.com/snowdreamtech/mariadb/commit/ca1a9c208d6aaf7c4d1a70bc890b8f0fab0b8830))
