FROM snowdreamtech/alpine:3.20.2

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV MARIADB_VERSION=10.11.8-r0 \
    MARIADB_ROOT_PASSWORD="" \
    REMOVE_ANONYMOUS_USERS=1 \
    DISALLOW_ROOT_LOGIN_REMOTELY=1 \
    REMOVE_TEST_DATABASE=1 

RUN apk add --no-cache mariadb=${MARIADB_VERSION} \
    mariadb-client=${MARIADB_VERSION} \
    expect

COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

COPY docker-entrypoint.sh mariadb-setup.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]