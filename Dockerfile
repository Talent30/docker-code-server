FROM alpine:3.14
RUN apk update --no-cache\
    && apk add nodejs npm fish alpine-sdk bash libstdc++ libc6-compat python3 --no-cache \
    && npm config set python python3 \
    && npm i -g code-server --unsafe-perm \
    && apk del alpine-sdk bash python3

ENTRYPOINT ["code-server"]
