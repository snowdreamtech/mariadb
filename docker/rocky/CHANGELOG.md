# Changelog

## [11.8.8](https://github.com/snowdreamtech/mariadb/compare/rocky-v11.8.6...rocky-v11.8.8) (2026-08-13)


### 🐛 Bug Fixes

* remove static version defaults from OCI image labels to use variable injection exclusively ([da5645a](https://github.com/snowdreamtech/mariadb/commit/da5645ad4d48467290235abbbd9f31ba70bf690f))
* use ghcr.io for base images to avoid rate limits ([9f1d73a](https://github.com/snowdreamtech/mariadb/commit/9f1d73a75a61f2f368f5572c4bd28f4c92ef8fd5))


### ♻️ Miscellaneous Chores

* add 0-git-keep.sh to prevent empty entrypoint.d directories ([ce77247](https://github.com/snowdreamtech/mariadb/commit/ce77247762becc1edf85ec7b57747d3f3127044a))
* **docker:** ignore unavailable repos for rocky build ([a6b6b6e](https://github.com/snowdreamtech/mariadb/commit/a6b6b6e5b2288cfeb6b2777902b85e7e5f37f2c3))
* release main ([5a92edb](https://github.com/snowdreamtech/mariadb/commit/5a92edb4ba76b04ee6de7369e9471f785849a7ae))
* release main ([4011a21](https://github.com/snowdreamtech/mariadb/commit/4011a21a23395acc9545168c95ca0ec5c867e7d3))
* release main ([d52be5c](https://github.com/snowdreamtech/mariadb/commit/d52be5cf0c5cff45f7f72e973d62c94b48855e1b))
* release main ([f66597a](https://github.com/snowdreamtech/mariadb/commit/f66597a5feae95e8853f4cc730c81e93e172f6ca))
* release main ([b3a5cc9](https://github.com/snowdreamtech/mariadb/commit/b3a5cc9ef0a64a7bc04ed7c2acf0cca5327c5c26))
* **release:** deduplicate CHANGELOG headers ([c2bba24](https://github.com/snowdreamtech/mariadb/commit/c2bba247dca89a31accc6e70c5e48b16170b1ce5))
* **release:** deduplicate CHANGELOG headers ([4f07b71](https://github.com/snowdreamtech/mariadb/commit/4f07b71194f58ba214f1fb60ce0dc56d71c499e2))
* **release:** deduplicate CHANGELOG headers ([3068d88](https://github.com/snowdreamtech/mariadb/commit/3068d883bc6167773d046d3b2b0e4c479e4fee39))
* **release:** deduplicate CHANGELOG headers ([82be3d5](https://github.com/snowdreamtech/mariadb/commit/82be3d5576b65b7f69b1a9afb8604f2c8f0e47f7))
* smart merge upstream/dev into dev and update MariaDB package versions ([25b01dd](https://github.com/snowdreamtech/mariadb/commit/25b01dd4f08e172cae2ece25330b335ae4df023b))
* **speckit:** manual auto-commit trigger ([5f8a5a9](https://github.com/snowdreamtech/mariadb/commit/5f8a5a9cba5d6bd42a65eaabfecd6e18b01aeeb0))

## [11.8.6](https://github.com/snowdreamtech/mariadb/compare/rocky-v11.8.6...rocky-v11.8.6) (2026-06-24)


### 🐛 Bug Fixes

* resolve infinite loop in mariadb-custom-installation do_query ([3f4365d](https://github.com/snowdreamtech/mariadb/commit/3f4365d48b70f8a4221552a1e255d43428561c4a))


### ♻️ Miscellaneous Chores

* fix formatting and shellcheck warnings ([8b49b6f](https://github.com/snowdreamtech/mariadb/commit/8b49b6f8ec05953dde950f59d191e061f4dbff3a))
