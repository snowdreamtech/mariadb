# Changelog

## [11.8.6](https://github.com/snowdreamtech/mariadb/compare/debian-v11.8.6...debian-v11.8.6) (2026-06-23)


### 🐛 Bug Fixes

* add crash detection and timeout guard to MariaDB startup loop ([190ce4f](https://github.com/snowdreamtech/mariadb/commit/190ce4fdb3893eaef1aab69b1184c41c34d3e13f))
* **debian,rocky:** explicitly create /run/mysqld for consistency ([e536430](https://github.com/snowdreamtech/mariadb/commit/e536430249e34b632a77c2feff4249391cf2379c))
* **debian:** skip mariadb-install-db if data directory already exists ([186d4a5](https://github.com/snowdreamtech/mariadb/commit/186d4a5256a6e732936f68c579f8f82d4d3e2b2a))
* guard stty calls with TTY check to prevent CI smoke test failure ([b58652b](https://github.com/snowdreamtech/mariadb/commit/b58652b4fa7dec8c784bef00d380611a82bf5849))

## [11.8.6](https://github.com/snowdreamtech/mariadb/compare/debian-v11.8.6...debian-v11.8.6) (2026-06-23)


### 🐛 Bug Fixes

* **docker:** replace \r with \n in expect scripts to fix rocky build hang ([ca1a9c2](https://github.com/snowdreamtech/mariadb/commit/ca1a9c208d6aaf7c4d1a70bc890b8f0fab0b8830))
