FROM snowdreamtech/alpine:3.20.2

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV MARIADB_VERSION=10.11.8-r0

RUN apk add --no-cache mariadb=${MARIADB_VERSION} \
    mariadb-client=${MARIADB_VERSION} 

EXPOSE 3306

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]