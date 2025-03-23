FROM snowdreamtech/debian:12.8.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="MariaDB Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for MariaDB on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/mariadb" \
    org.opencontainers.image.base.name="snowdreamtech/mariadb:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/mariadb" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="10.11.11" \
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

ENV MARIADB_VERSION=1:10.11.11-0+deb12u1 \
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
RUN set -eux \
    && if [ "${USER}" != "root" ]; then \
    addgroup --gid ${GID} ${USER}; \
    adduser --home ${WORKDIR} --uid ${UID} --gid ${GID} --gecos ${USER} --shell /bin/bash --disabled-password ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* 

# Enable CAP_NET_BIND_SERVICE
RUN set -eux \
    && if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy update; \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install --no-install-recommends libcap2-bin; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* 

RUN set -eux \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy update  \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy install --no-install-recommends \ 
    mariadb-server=${MARIADB_VERSION} \
    mariadb-client=${MARIADB_VERSION} \
    expect \
    && mkdir -p /run/mysqld/ \
    && chown -Rv ${USER}:${USER} /run/mysqld/ \
    # Chown the files to USER
    # && chown -Rv ${USER}:${USER} /etc/my.cnf.d \
    && find /etc  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/share  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/bin  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /var/lib  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/lib  -name "*mysql*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /etc  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/share  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/bin  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /var/lib  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/lib  -name "*mariadb*" -exec chown -Rv ${USER}:${USER} {} \; \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Switch to the user
# USER ${USER}
USER root

# Set the workdir
WORKDIR ${WORKDIR}

EXPOSE 3306

COPY --chown=${USER}:${USER} docker-entrypoint.sh mariadb-custom-installation mariadb-setup /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]