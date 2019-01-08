FROM alpine:3.8

ARG VCS_REF
ARG BUILD_DATE

ENV REPOSITORY sgerrand/alpine-pkg-git-crypt
ENV VERSION 0.6.0-r0

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/apihackers/docker-git-crypt" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

RUN apk add --no-cache gnupg && \
    apk add --no-cache --virtual .build-deps wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/$REPOSITORY/master/sgerrand.rsa.pub && \
    wget https://github.com/$REPOSITORY/releases/download/$VERSION/git-crypt-$VERSION.apk && \
    apk add git-crypt-$VERSION.apk && \
    rm git-crypt-$VERSION.apk && \
    apk del .build-deps

ENV GPG_PRIVATE_KEY ""

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
