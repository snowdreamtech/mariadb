FROM snowdreamtech/alpine:3.21.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="MariaDB Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for MariaDB on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/mariadb" \
    org.opencontainers.image.base.name="snowdreamtech/mariadb:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/mariadb" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="11.4.4" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/mariadb"

# Switch to the user
USER root

# Set the workdir
WORKDIR /root

# keep the docker container running
ENV KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=0 

ENV MARIADB_VERSION=11.4.4-r1 \
    MARIADB_PORT=3306 \
    MARIADB_ROOT_PASSWORD="" \
    MARIADB_DATABASE="" \
    MARIADB_USER="" \
    MARIADB_PASSWORD="" \
    REMOVE_ANONYMOUS_USERS=1 \
    DISALLOW_ROOT_LOGIN_REMOTELY=1 \
    DISALLOW_USER_LOGIN_REMOTELY=1 \
    REMOVE_TEST_DATABASE=1

ARG GID=1000 \
    UID=1000  \
    USER=mysql \
    WORKDIR=/var/lib/mysql

# Create a user with UID and GID
RUN if [ "${USER}" != "root" ]; then \
    addgroup -g ${GID} ${USER}; \
    adduser -h ${WORKDIR} -u ${UID} -g ${USER} -G ${USER} -s /bin/sh -D ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi

# Enable CAP_NET_BIND_SERVICE
RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    apk add --no-cache libcap; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi

RUN apk add --no-cache mariadb=${MARIADB_VERSION} \
    mariadb-client=${MARIADB_VERSION} \
    expect \
    && mkdir -p /run/mysqld/ \
    && chown -Rv ${USER}:${USER} /run/mysqld/ \
    # Chown the files to USER
    && chown -Rv ${USER}:${USER} /etc/my.cnf.d \
    && find /etc  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/share  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/bin  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /var/lib  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/lib  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /etc  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/share  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/bin  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /var/lib  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/lib  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; 

# Switch to the user
# USER ${USER}
USER root

# Set the workdir
WORKDIR ${WORKDIR}

EXPOSE 3306

COPY --chown=${USER}:${USER} docker-entrypoint.sh mariadb-custom-installation mariadb-setup /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

# # Switch to the user
# USER ${USER}

# # Set the workdir
# WORKDIR ${WORKDIR}
