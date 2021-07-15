FROM alpine:3.14
RUN apk update --no-cache\
    && apk add nodejs npm fish nano alpine-sdk bash libstdc++ libc6-compat python3 --no-cache \
    && npm config set python python3 \
    && npm i -g code-server --unsafe-perm

ENTRYPOINT ["code-server"]
