FROM alpine:3.14
RUN apk update \
    && apk upgrade -a \
    && apk add nodejs npm fish nano alpine-sdk bash libstdc++ libc6-compat python3\
    && npm config set python python3 \
    && npm i -g code-server
ENTRYPOINT ["code-server"]