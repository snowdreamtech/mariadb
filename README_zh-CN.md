# MariaDB

[![CI Pipeline](https://img.shields.io/github/actions/workflow/status/snowdreamtech/mariadb/ci.yml?branch=main&label=CI%20Pipeline)](https://github.com/snowdreamtech/mariadb/actions/workflows/ci.yml)
[![CD Pipeline](https://img.shields.io/github/actions/workflow/status/snowdreamtech/mariadb/cd.yml?branch=main&label=CD%20Pipeline)](https://github.com/snowdreamtech/mariadb/actions/workflows/cd.yml)
[![CodeQL](https://img.shields.io/github/actions/workflow/status/snowdreamtech/mariadb/codeql.yml?branch=main&label=CodeQL&logo=github)](https://github.com/snowdreamtech/mariadb/actions/workflows/codeql.yml)
[![Security Audit](https://img.shields.io/badge/Security-Zizmor%20%7C%20Trivy%20%7C%20Gitleaks-brightgreen)](https://github.com/snowdreamtech/mariadb/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/license/MIT)
![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/mariadb)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/mariadb/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/mariadb)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/mariadb)

[English](README.md) | [简体中文](README_zh-CN.md)

基于 Alpine、Debian 和 Rocky Linux 构建的标准化 MariaDB 容器镜像，具备灵活的 entrypoint 初始化系统、多架构支持及统一的环境变量配置模式。

## 概述

MariaDB 容器镜像提供：

- **标准化 Dockerfile**，遵循 OCI 规范与最佳实践
- **灵活的 entrypoint 系统**，支持自定义初始化脚本
- **统一的环境变量配置**，跨所有发行版变体保持一致
- **多架构支持**，适配多样化的硬件平台
- **用户/组管理**，支持 PUID/PGID 权限处理
- **三种发行版变体**：Alpine（轻量级）、Debian（默认/高兼容性）、Rocky（企业级）
- **镜像别名**：同时发布至 `snowdreamtech/mysql` 与 `ghcr.io/snowdreamtech/mysql` 别名仓库

## 快速上手

```bash
# 拉取并运行默认 Debian 变体
docker pull snowdreamtech/mariadb:debian
docker run -d --name=mariadb -p 3306:3306 -e TZ=Asia/Shanghai snowdreamtech/mariadb:debian

# 或使用 docker compose
docker compose up -d
```

## 发行版变体

### Debian（默认）

推荐用于大多数场景，提供广泛的兼容性和丰富的软件包生态。

```bash
docker run -d \
  --name=mariadb \
  -p 3306:3306 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/mariadb:debian
```

**支持的架构**：amd64, arm32v7, arm64, ppc64le, riscv64, s390x

**基础镜像**：`snowdreamtech/debian:13.6.0`

### Alpine

经过轻量化优化的变体，具有极小的镜像体积和极快的启动速度。

```bash
docker run -d \
  --name=mariadb \
  -p 3306:3306 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/mariadb:alpine
```

**支持的架构**：386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x

**基础镜像**：`snowdreamtech/alpine:3.24.1`

### Rocky

针对企业级场景的变体，基于 Rocky Linux 构建，适合需要 RHEL 兼容性的生产环境。

```bash
docker run -d \
  --name=mariadb \
  -p 3306:3306 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/mariadb:rocky
```

**支持的架构**：amd64, arm64, ppc64le, s390x

**基础镜像**：`snowdreamtech/rocky:10.2.0`

## 构建说明

### 单架构本地构建

```bash
# 构建 Debian 变体
docker build -t snowdreamtech/mariadb:debian ./docker/debian/

# 构建 Alpine 变体
docker build -t snowdreamtech/mariadb:alpine ./docker/alpine/

# 构建 Rocky 变体
docker build -t snowdreamtech/mariadb:rocky ./docker/rocky/
```

### 多架构构建

使用 `docker buildx` 进行多架构镜像构建：

```bash
# 创建并启用 buildx 构建器
docker buildx create --use --name build --node build --driver-opt network=host

# 构建 Debian 多架构镜像
docker buildx build \
  --platform=linux/amd64,linux/arm/v7,linux/arm64,linux/riscv64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/mariadb:debian \
  ./docker/debian/ \
  --push

# 构建 Alpine 多架构镜像
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/mariadb:alpine \
  ./docker/alpine/ \
  --push

# 构建 Rocky 多架构镜像
docker buildx build \
  --platform=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/mariadb:rocky \
  ./docker/rocky/ \
  --push
```

## 环境变量

所有发行版变体均支持以下运行时环境变量：

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `KEEPALIVE` | `1` | 保持容器持续运行（1=启用，0=禁用） |
| `CAP_NET_BIND_SERVICE` | `0` | 允许绑定特权端口（<1024） |
| `LANG` | `C.UTF-8` | 区域语言设置，支持 UTF-8 字符集 |
| `UMASK` | `022` | 默认文件创建掩码 |
| `DEBUG` | `false` | 启用 entrypoint 脚本的调试输出 |
| `PGID` | `0` | 自定义用户的主组 ID |
| `PUID` | `0` | 自定义用户的用户 ID |
| `USER` | `root` | 自定义用户名 |
| `WORKDIR` | `/root` | 工作目录路径 |
| `TZ` | - | 时区（例如 `Asia/Shanghai`、`America/New_York`） |
| `MARIADB_ROOT_PWD` | - | MariaDB root 用户密码（未设置时自动生成随机密码） |
| `MARIADB_PORT` | `3306` | MariaDB 服务监听端口 |
| `DISALLOW_ROOT_LOGIN_REMOTELY` | `1` | 禁止 root 用户远程登录（1=启用，0=禁用） |
| `DISALLOW_USER_LOGIN_REMOTELY` | `1` | 禁止普通用户远程登录（1=启用，0=禁用） |
| `REMOVE_ANONYMOUS_USERS` | `1` | 初始化时移除匿名用户（1=启用，0=禁用） |

**Debian 专用变量**：

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian 软件包安装交互模式 |

### 自定义用户创建

在构建时创建具有特定 UID/GID 的非 root 用户：

```bash
docker build \
  --build-arg PUID=1000 \
  --build-arg PGID=1000 \
  --build-arg USER=appuser \
  -t snowdreamtech/mariadb:debian-custom \
  ./docker/debian/
```

或在运行时指定：

```bash
docker run -d \
  --name=mariadb \
  -e PUID=1000 \
  -e PGID=1000 \
  -e USER=appuser \
  snowdreamtech/mariadb:debian
```

**说明**：仅当同时满足 `PUID≠0`、`PGID≠0` 且 `USER≠root` 时才会触发用户创建。

## Docker Compose 示例

### 基础配置

```yaml
services:
  mariadb:
    image: snowdreamtech/mariadb:debian
    container_name: mariadb
    ports:
      - "3306:3306"
    environment:
      - TZ=Asia/Shanghai
    restart: unless-stopped
```

### 进阶配置

```yaml
services:
  mariadb:
    image: snowdreamtech/mariadb:debian
    container_name: mariadb
    ports:
      - "3306:3306"
    environment:
      - TZ=Asia/Shanghai
      - DEBUG=true
      - KEEPALIVE=1
      - MARIADB_ROOT_PWD=my_secret_password
    volumes:
      - /path/to/data:/var/lib/mysql
    restart: unless-stopped
```

## 语义化版本标签

镜像严格遵循语义化版本规范，标签命名格式为：`{major}.{minor}.{patch}-{variant}`

示例：

- `snowdreamtech/mariadb:11.8.6-debian`
- `snowdreamtech/mariadb:11.8.9-alpine`
- `snowdreamtech/mariadb:11.8.8-rocky`

该策略支持：

- **精确版本锁定**：`<version>-debian`（锁定具体版本）
- **变体最新标签**：`latest-debian`（追踪 Debian 最新构建）
- **全局最新标签**：`latest`（追踪整体最新构建，默认指向 Debian）

## 架构支持

各发行版变体支持多种 CPU 架构，以满足不同硬件环境的部署需求：

| 变体 | 支持架构 |
|------|----------|
| **Debian** | amd64, arm32v7, arm64, ppc64le, riscv64, s390x |
| **Alpine** | 386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x |
| **Rocky** | amd64, arm64, ppc64le, s390x |

拉取镜像时，Docker 会自动匹配适合当前宿主机平台的架构版本。

## Entrypoint 系统

镜像内置灵活的 entrypoint 系统，在启动应用程序前按顺序执行自定义初始化脚本。

### 工作机制

1. 容器启动时运行 `docker-entrypoint.sh` 脚本
2. 按字典序依次执行 `/usr/local/bin/entrypoint.d/` 目录下的所有可执行脚本
3. 每个脚本都会接收容器传入的命令行参数
4. 任何脚本执行失败都会导致容器立即终止（快速失败机制）

### 添加自定义初始化脚本

在基于本镜像衍生的 Dockerfile 中添加初始化脚本：

```dockerfile
FROM snowdreamtech/mariadb:debian

# 添加自定义初始化脚本
COPY my-init.sh /usr/local/bin/entrypoint.d/20-my-init.sh
RUN chmod +x /usr/local/bin/entrypoint.d/20-my-init.sh

# 应用程序配置
COPY app /app
CMD ["/app/start.sh"]
```

### 调试模式

启用调试模式以排查 entrypoint 执行过程中的问题：

```bash
docker run -e DEBUG=true snowdreamtech/mariadb:debian
```

## 联系方式 (备注：mariadb)

* 邮箱: <sn0wdr1am@qq.com>
* QQ: 3217680847
* QQ群: 949022145
* WeChat/微信群: sn0wdr1am

## 许可证

本项目基于 [MIT](LICENSE) 许可证开源。
